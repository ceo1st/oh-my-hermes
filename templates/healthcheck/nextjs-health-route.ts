import { NextResponse } from "next/server";

// Copy to: src/app/api/health/route.ts
// Returns HTTP 200 with { status, version, timestamp } when healthy.
// Uptime Kuma and health-check skill poll this endpoint.
export async function GET() {
  return NextResponse.json({
    status: "ok",
    version: process.env.npm_package_version ?? "1.0.0",
    timestamp: new Date().toISOString(),
  });
}
