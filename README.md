# TM-FIAP-Infra

Infraestrutura do projeto **Tech Challenge - Fase 2** da FIAP.

Este repositório centraliza a execução dos microsserviços da plataforma de **Feature Flags**, utilizando Docker Compose para orquestrar containers de aplicação, bancos de dados PostgreSQL e Redis.

## 📖 Visão Geral

A solução é composta por microsserviços independentes responsáveis por autenticação, gerenciamento de feature flags, segmentação de usuários, avaliação de regras e coleta de métricas.

Toda a infraestrutura pode ser iniciada localmente através de um único arquivo `docker-compose.yml`.

---

## 🏗️ Arquitetura

O ambiente é composto por **9 containers**:

### Bancos de Dados

| Serviço      | Tecnologia | Porta |
| ------------ | ---------- | ----- |
| auth-db      | PostgreSQL | 5433  |
| flags-db     | PostgreSQL | 5432  |
| targeting-db | PostgreSQL | 5434  |
| redis        | Redis      | 6379  |

### Microsserviços

| Serviço            | Tecnologia | Porta |
| ------------------ | ---------- | ----- |
| auth-service       | Go         | 8001  |
| flag-service       | Python     | 8002  |
| targeting-service  | Python     | 8003  |
| evaluation-service | Go         | 8004  |
| analytics-service  | Python     | 8005  |

---

## 🚀 Como Executar

### 1. Clonar o repositório

```bash
git clone https://github.com/<seu-usuario>/TM-fiap-infra.git
cd TM-fiap-infra
```

### 2. Configurar variáveis de ambiente

Copie o arquivo de exemplo:

```bash
cp .env.example .env
```

Preencha os valores necessários antes de iniciar os containers.

### 3. Construir e iniciar os serviços

```bash
docker compose up -d --build
```

### 4. Verificar os containers

```bash
docker ps
```

Todos os 9 containers devem estar em execução.

---

## ❤️ Health Checks

Cada microsserviço possui um endpoint de saúde:

```bash
curl http://localhost:8001/health
curl http://localhost:8002/health
curl http://localhost:8003/health
curl http://localhost:8004/health
curl http://localhost:8005/health
```

### Resposta esperada

```json
{
  "status": "ok"
}
```

---

## 🗄️ Acessando os Bancos

### PostgreSQL

Auth Database:

```bash
docker exec -it auth-db psql -U postgres -d auth_db
```

Flags Database:

```bash
docker exec -it flags-db psql -U postgres -d flags_db
```

Targeting Database:

```bash
docker exec -it targeting-db psql -U postgres -d targeting_db
```

### Redis

```bash
docker exec -it redis redis-cli ping
```

Resposta esperada:

```text
PONG
```

---

## 🔐 Segurança

As credenciais e informações sensíveis não devem ser armazenadas no GitHub.

Utilize um arquivo `.env` local e mantenha-o listado no `.gitignore`.

### Exemplo de `.env.example`

```env
AWS_ACCESS_KEY_ID=changeme
AWS_SECRET_ACCESS_KEY=changeme
AWS_SQS_URL=changeme
SERVICE_API_KEY=changeme
```

---

## 📂 Estrutura do Projeto

```text
TM-fiap-infra/
│
├── auth-service/
├── flag-service/
├── targeting-service/
├── evaluation-service/
├── analytics-service/
│
├── docker-compose.yml
├── .env
├── .env.example
├── README.md
│
└── docs/
    ├── arquitetura.png
    └── evidencias/
```

---

## 🎯 Objetivo do Projeto

Este projeto foi desenvolvido como parte do Tech Challenge da FIAP com o objetivo de aplicar conceitos de:

* Arquitetura de Microsserviços
* Docker e Docker Compose
* Bancos de Dados PostgreSQL
* Redis Cache
* Integração entre Serviços
* Boas práticas de DevOps
* Infraestrutura como Código
* Observabilidade e Escalabilidade

---

## 👨‍💻 Autor

Projeto desenvolvido para a Pós-Tech FIAP – Arquitetura de Sistemas, DevOps e Cloud Computing.
