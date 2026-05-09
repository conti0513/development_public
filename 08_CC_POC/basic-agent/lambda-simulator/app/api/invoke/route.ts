import { NextRequest, NextResponse } from "next/server";
import { LambdaFunction } from "../functions/route";
import vm from "vm";

export type InvokeLog = {
  id: string;
  functionId: string;
  functionName: string;
  event: unknown;
  result: unknown;
  error: string | null;
  durationMs: number;
  invokedAt: string;
};

export const invokeLogs: InvokeLog[] = [];

// Shared in-memory functions store — imported via dynamic require to avoid circular deps
// We re-fetch from the functions route's in-memory map by calling the GET handler directly.
// Simpler: keep a module-level registry that both routes share.
import { functionsStore } from "../store";

export async function POST(req: NextRequest) {
  const { functionId, event } = await req.json();

  const fn: LambdaFunction | undefined = functionsStore.get(functionId);
  if (!fn) {
    return NextResponse.json({ error: "Function not found" }, { status: 404 });
  }

  const start = Date.now();
  let result: unknown = null;
  let error: string | null = null;

  try {
    const sandbox: Record<string, unknown> = { exports: {}, console };
    vm.createContext(sandbox);
    vm.runInContext(fn.code, sandbox, { timeout: 3000 });

    const handler = (sandbox.exports as Record<string, unknown>).handler;
    if (typeof handler !== "function") throw new Error("exports.handler is not a function");

    result = await handler(event ?? {});
  } catch (e) {
    error = e instanceof Error ? e.message : String(e);
  }

  const log: InvokeLog = {
    id: crypto.randomUUID(),
    functionId: fn.id,
    functionName: fn.name,
    event: event ?? {},
    result,
    error,
    durationMs: Date.now() - start,
    invokedAt: new Date().toISOString(),
  };

  invokeLogs.unshift(log);
  if (invokeLogs.length > 100) invokeLogs.pop();

  return NextResponse.json(log);
}
