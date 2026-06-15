#!/usr/bin/env sh
set -eu

IMAGE_NAME="${IMAGE_NAME:-devops-fase2-api:local}"
CONTAINER_NAME="${CONTAINER_NAME:-devops-fase2-api}"
PORT="${PORT:-3000}"

docker build -t "$IMAGE_NAME" .

if docker ps -q --filter "name=^/${CONTAINER_NAME}$" | grep -q .; then
  docker stop "$CONTAINER_NAME" >/dev/null
fi

if docker ps -aq --filter "name=^/${CONTAINER_NAME}$" | grep -q .; then
  docker rm "$CONTAINER_NAME" >/dev/null
fi

docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$PORT:3000" \
  -e NODE_ENV=production \
  -e PORT=3000 \
  --restart unless-stopped \
  "$IMAGE_NAME" >/dev/null

echo "Deploy concluido em http://localhost:$PORT/health"
