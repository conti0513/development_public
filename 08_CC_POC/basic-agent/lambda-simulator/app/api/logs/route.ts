import { NextResponse } from "next/server";
import { invokeLogs } from "../invoke/route";

export async function GET() {
  return NextResponse.json(invokeLogs);
}
