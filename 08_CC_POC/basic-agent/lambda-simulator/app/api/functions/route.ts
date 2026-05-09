import { NextRequest, NextResponse } from "next/server";
import { functionsStore } from "../store";

export type LambdaFunction = {
  id: string;
  name: string;
  runtime: "nodejs";
  code: string;
  createdAt: string;
};

export async function GET() {
  return NextResponse.json(Array.from(functionsStore.values()));
}

export async function POST(req: NextRequest) {
  const { name, code } = await req.json();

  if (!name || !code) {
    return NextResponse.json({ error: "name and code are required" }, { status: 400 });
  }

  const fn: LambdaFunction = {
    id: name.toLowerCase().replace(/\s+/g, "-"),
    name,
    runtime: "nodejs",
    code,
    createdAt: new Date().toISOString(),
  };

  functionsStore.set(fn.id, fn);
  return NextResponse.json(fn, { status: 201 });
}

export async function DELETE(req: NextRequest) {
  const { id } = await req.json();
  functionsStore.delete(id);
  return NextResponse.json({ ok: true });
}
