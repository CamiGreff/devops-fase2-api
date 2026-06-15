param(
  [string]$ImageName = "devops-fase2-api:local",
  [int]$Port = 3000
)

$ErrorActionPreference = "Stop"
$ContainerName = "devops-fase2-api"

docker build -t $ImageName .

$running = docker ps -q --filter "name=^/${ContainerName}$"
if ($running) {
  docker stop $ContainerName | Out-Null
}

$existing = docker ps -aq --filter "name=^/${ContainerName}$"
if ($existing) {
  docker rm $ContainerName | Out-Null
}

docker run -d `
  --name $ContainerName `
  -p "${Port}:3000" `
  -e NODE_ENV=production `
  -e PORT=3000 `
  --restart unless-stopped `
  $ImageName | Out-Null

Write-Host "Deploy concluido em http://localhost:$Port/health"
