import assert from "node:assert/strict";
import test from "node:test";
import type { Server } from "node:http";
import { createServer } from "../src/app.ts";

async function request(server: Server, path: string): Promise<Response> {
  const address = server.address();

  if (address === null || typeof address === "string") {
    throw new Error("Server address is not available");
  }

  return fetch(`http://127.0.0.1:${address.port}${path}`);
}

test("GET /health returns service status", async () => {
  const server = createServer().listen(0);

  try {
    const response = await request(server, "/health");
    const body = await response.json();

    assert.equal(response.status, 200);
    assert.deepEqual(body, { status: "ok", service: "devops-fase2-api" });
  } finally {
    server.close();
  }
});

test("unknown routes return 404", async () => {
  const server = createServer().listen(0);

  try {
    const response = await request(server, "/nao-existe");

    assert.equal(response.status, 404);
  } finally {
    server.close();
  }
});
