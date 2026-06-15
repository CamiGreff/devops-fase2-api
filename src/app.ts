import { createServer as createHttpServer, type IncomingMessage, type ServerResponse } from "node:http";

export type HealthResponse = {
  status: "ok";
  service: string;
};

function sendJson(res: ServerResponse, statusCode: number, body: unknown): void {
  res.writeHead(statusCode, { "Content-Type": "application/json" });
  res.end(JSON.stringify(body));
}

export function requestHandler(req: IncomingMessage, res: ServerResponse): void {
  if (req.method === "GET" && req.url === "/health") {
    const response: HealthResponse = {
      status: "ok",
      service: "devops-fase2-api",
    };

    sendJson(res, 200, response);
    return;
  }

  sendJson(res, 404, { error: "not_found" });
}

export function createServer() {
  return createHttpServer(requestHandler);
}
