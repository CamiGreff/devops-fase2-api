# DevOps Fase 2 API

Projeto desenvolvido por **Camila Silva Greff** para a disciplina **DevOps na Prática**.

Este projeto demonstra a evolução de uma aplicação simples em TypeScript para um fluxo DevOps com Integração Contínua, Entrega Contínua, containerização com Docker, scripts de deploy, monitoramento básico, logging, testes automatizados, segurança e Infraestrutura como Código.

## Repositório GitHub

```text
https://github.com/CamiGreff/devops-fase2-api
```

## Objetivo do projeto

O objetivo do projeto é aplicar, de forma prática, conceitos de DevOps em uma API HTTP desenvolvida com Node.js e TypeScript.

Na fase 1, o foco esteve na configuração inicial do projeto, criação do repositório, implementação de testes automatizados, configuração do pipeline de Integração Contínua com GitHub Actions e criação de scripts de Infraestrutura como Código com Terraform.

Na fase 2, o projeto foi expandido para incluir Entrega Contínua, containerização com Docker, execução por Docker Compose, scripts de deploy local, monitoramento básico por healthcheck, logging por containers, práticas de segurança e relatório final do fluxo DevOps.

## Resumo da Fase 1

A primeira fase teve como tema **Configuração e Automação Inicial**.

Foram implementados os seguintes itens:

* API em TypeScript;
* endpoint de saúde `GET /health`;
* testes automatizados;
* repositório versionado no GitHub;
* pipeline de Integração Contínua com GitHub Actions;
* validação de build e testes no pipeline;
* scripts de Infraestrutura como Código com Terraform;
* documentação inicial do projeto.

A fase 1 serviu como base para a evolução do projeto na fase 2.

## Fase 2 - Entrega Contínua, Monitoramento e Segurança

A segunda fase amplia o projeto com práticas de Entrega Contínua, containers, deploy, monitoramento, logging, testes e segurança.

Foram implementados os seguintes itens:

* expansão do pipeline de CI para CI/CD;
* build da imagem Docker;
* publicação da imagem no GitHub Container Registry em push na branch `main`;
* containerização da aplicação com `Dockerfile`;
* execução local com `docker-compose.yml`;
* scripts de deploy local para Windows e Linux/macOS;
* healthcheck da aplicação pelo endpoint `/health`;
* logs consultáveis por Docker;
* uso de variáveis de ambiente;
* práticas de segurança para evitar credenciais no repositório;
* relatório final da fase 2;
* fluxograma do fluxo DevOps.

## Tecnologias utilizadas

```text
Node.js
TypeScript
GitHub
GitHub Actions
Docker
Docker Compose
Terraform
GitHub Container Registry
```

## Estrutura do projeto

```text
devops-fase2-api/
|-- src/
|   |-- app.ts
|   `-- server.ts
|-- tests/
|   `-- app.test.ts
|-- infra/
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
|   `-- terraform.tfvars.example
|-- scripts/
|   |-- deploy-local.ps1
|   `-- deploy-local.sh
|-- docs/
|   |-- relatorio-fase2.md
|   `-- relatorio-fase2.pdf
|-- .github/
|   `-- workflows/
|       `-- ci.yml
|-- Dockerfile
|-- docker-compose.yml
|-- package.json
|-- tsconfig.json
|-- README.md
`-- .gitignore
```

## Aplicação

A aplicação é uma API HTTP simples em Node.js com TypeScript.

O endpoint principal é:

```text
GET /health
```

Esse endpoint retorna o estado da aplicação e é usado também como verificação de saúde do container.

Exemplo de resposta esperada:

```json
{
  "status": "ok",
  "service": "devops-fase2-api"
}
```

## Como executar localmente

Instale as dependências:

```bash
npm install
```

Execute a aplicação:

```bash
npm start
```

A API ficará disponível em:

```text
http://localhost:3000/health
```

Para encerrar o servidor no terminal, pressione:

```text
Ctrl+C
```

## Testes automatizados

Execute os testes com:

```bash
npm test
```

Os testes verificam:

* retorno correto do endpoint `/health`;
* retorno `404` para rotas inexistentes.

Os testes são executados tanto no pipeline de CI/CD quanto durante o processo de build da imagem Docker.

## Docker Compose

Para a demonstração da fase 2, foi utilizado Docker Compose como forma principal de execução local com container.

Antes de subir a aplicação, caso exista container anterior em execução, é possível encerrar o ambiente com:

```bash
docker compose down
```

Em seguida, construir a imagem e subir o container:

```bash
docker compose up -d --build
```

Verificar os containers em execução:

```bash
docker ps
```

Testar o endpoint de saúde:

```test
http://localhost:3000/health
```

No PowerShell, o teste pode ser feito com:

```bash
Invoke-RestMethod http://localhost:3000/health
```

Consultar os logs do container:

```bash
docker logs devops-fase2-api
```

Encerrar a aplicação:

```bash
docker compose down
```

O projeto também contém scripts de deploy local em:

```powershell
scripts/deploy-local.ps1
```
```bash
scripts/deploy-local.sh
```

Esses scripts foram criados como alternativa para automatizar o build da imagem, a remoção de container anterior e a criação de um novo container.

Para evitar conflito entre containers criados pelo Docker Compose e containers criados diretamente pelos scripts, a demonstração principal deste projeto utiliza apenas o fluxo com Docker Compose.

## Pipeline CI/CD

O workflow `.github/workflows/ci.yml` executa as etapas de Integração Contínua e Entrega Contínua.

Principais etapas:

```text
1. Checkout do código
2. Instalação das dependências
3. Build da aplicação TypeScript
4. Execução dos testes automatizados
5. Validação dos arquivos Terraform
6. Build da imagem Docker
7. Publicação da imagem no GitHub Container Registry em push na branch main
```

Em pull requests, o pipeline executa as validações de qualidade, build, testes, Terraform e build Docker, mas não publica imagem.

Em push na branch `main`, a imagem Docker é publicada no GitHub Container Registry com as tags:

```text
latest
sha-<commit>
```

## Docker

A aplicação foi containerizada com Docker.

O `Dockerfile` utiliza build em múltiplos estágios:

* estágio de build: instala dependências, compila TypeScript e executa testes;
* estágio de produção: instala apenas dependências de produção e copia os arquivos compilados.


## Scripts de deploy local

Foram criados scripts para automatizar o processo de deploy local com containers.

### Windows PowerShell

```powershell
.\scripts\deploy-local.ps1
```

### Linux/macOS

```bash
sh scripts/deploy-local.sh
```

Os scripts realizam as seguintes ações:

```text
1. Constroem a imagem Docker.
2. Verificam se já existe container antigo com o mesmo nome.
3. Param e removem o container antigo, se existir.
4. Criam um novo container.
5. Publicam a aplicação na porta 3000.
6. Exibem o endereço de teste do endpoint /health.
```

## Monitoramento e logging

O monitoramento básico foi implementado por meio do endpoint:

```text
GET /health
```

Esse endpoint é usado para verificar se a aplicação está respondendo corretamente.

Também foi configurado healthcheck no ambiente de container, permitindo acompanhar a saúde da aplicação.

Os logs são enviados para a saída padrão do container e podem ser consultados com:

```bash
docker logs devops-fase2-api
```

Em um ambiente real, os logs poderiam ser enviados para ferramentas como:

```text
Grafana Loki
ELK Stack
Amazon CloudWatch
Datadog
```

## Segurança

As principais práticas de segurança aplicadas no projeto foram:

* ausência de credenciais sensíveis no repositório;
* uso do `GITHUB_TOKEN` no GitHub Actions para publicação no registry;
* separação entre validação de pull request e publicação em push na branch `main`;
* uso de `.gitignore` e `.dockerignore` para evitar envio de arquivos locais, logs, `node_modules`, estados Terraform e variáveis sensíveis;
* imagem final menor, com apenas dependências de produção;
* variáveis de ambiente para configurações como `PORT` e `NODE_ENV`.

## Gerenciamento de configurações

As principais configurações foram externalizadas por variáveis:

```text
PORT
NODE_ENV
```

A porta padrão da aplicação é:

```text
3000
```

As variáveis da infraestrutura ficam documentadas em:

```text
infra/terraform.tfvars.example
```

Essa abordagem evita valores fixos diretamente no código e facilita a execução em diferentes ambientes.

## Infraestrutura como Código

Os scripts Terraform ficam na pasta:

```text
infra/
```

Arquivos principais:

```text
main.tf
variables.tf
outputs.tf
terraform.tfvars.example
```

Comandos básicos:

```bash
cd infra
terraform init
terraform validate
terraform plan -var="bucket_name=cami-greff-devops-fase2-api"
```

As credenciais da AWS não devem ser escritas nos arquivos do projeto. Em ambiente real, elas devem ser configuradas localmente ou armazenadas como secrets no GitHub Actions.