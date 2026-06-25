# Docker Compose - Orquestração do Ambiente Local

## Objetivo

Após a conteinerização individual dos cinco microsserviços, foi necessário criar um ambiente único capaz de inicializar toda a aplicação de forma automatizada.

Para isso foi utilizado o Docker Compose, permitindo que todos os microsserviços e bancos de dados fossem executados simultaneamente através de um único arquivo de configuração.

Essa abordagem simplifica o desenvolvimento local, reduz o tempo de preparação do ambiente e garante que todos os componentes sejam iniciados de forma padronizada.

---

# O que é o Docker Compose?

Docker Compose é uma ferramenta utilizada para definir e executar aplicações compostas por múltiplos containers.

Ao invés de iniciar cada container manualmente utilizando diversos comandos `docker run`, o Docker Compose utiliza um único arquivo `docker-compose.yml`, descrevendo toda a infraestrutura necessária para a aplicação.

Com isso, um único comando é suficiente para inicializar todo o ambiente.

```bash
docker compose up -d
```

---

# Por que utilizamos Docker Compose?

O projeto é composto por cinco microsserviços que dependem de diferentes bancos de dados e serviços auxiliares.

Executar cada container manualmente tornaria o ambiente complexo e sujeito a erros.

O Docker Compose foi utilizado para:

* Automatizar a criação do ambiente;
* Centralizar todas as configurações em um único arquivo;
* Criar automaticamente a rede entre os containers;
* Facilitar o desenvolvimento local;
* Simular uma arquitetura semelhante à utilizada na nuvem.

---

# Arquitetura do ambiente local

```text
                         Docker Compose

                               │

        ┌──────────────────────┴──────────────────────┐

        │                                             │

  Microsserviços                               Bancos de Dados

        │                                             │

 ├── auth-service                           ├── PostgreSQL (Auth)

 ├── flag-service                           ├── PostgreSQL (Flags)

 ├── targeting-service                      ├── Redis

 ├── evaluation-service                     └── DynamoDB Local

 └── analytics-service

```

Todos os containers compartilham a mesma rede Docker, permitindo comunicação entre eles utilizando apenas o nome do serviço.

---

# Estrutura do projeto

```text
TM-fiap-infra/

├── analytics-service/
├── auth-service/
├── evaluation-service/
├── flag-service/
├── targeting-service/
│
└── docker-compose.yml
```

O arquivo `docker-compose.yml` foi centralizado na raiz do projeto, tornando-se o ponto único de inicialização de todo o ambiente.

---

# Serviços orquestrados

Foram definidos os seguintes containers:

## Microsserviços

* auth-service
* flag-service
* targeting-service
* evaluation-service
* analytics-service

## Bancos de Dados

* PostgreSQL (Auth)
* PostgreSQL (Flags)
* Redis
* DynamoDB Local

---

# Comunicação entre os containers

O Docker Compose cria automaticamente uma rede virtual para o projeto.

Isso permite que os microsserviços utilizem nomes de host ao invés de endereços IP.

Exemplo:

```text
auth-service
      │
      ▼
 flags-db:5432
```

Ao invés de:

```text
172.18.0.12
```

Essa abordagem facilita a manutenção da aplicação e elimina dependências de endereços IP fixos.

---

# Fluxo de inicialização

```text
docker compose up -d

        │

        ▼

Criação da rede Docker

        │

        ▼

Inicialização dos bancos

        │

        ▼

Inicialização dos microsserviços

        │

        ▼

Ambiente pronto para testes
```

---

# Benefícios obtidos

A utilização do Docker Compose trouxe diversos benefícios para o projeto:

* Ambiente totalmente reproduzível;
* Inicialização com um único comando;
* Rede automática entre containers;
* Facilidade para testes locais;
* Simulação da arquitetura distribuída;
* Base para migração futura para Kubernetes.

---

# Tecnologias utilizadas

* Docker
* Docker Compose
* PostgreSQL
* Redis
* DynamoDB Local

---

# O que aprendi nesta etapa

Durante esta fase foram consolidados os seguintes conceitos:

* Diferença entre Docker e Docker Compose;
* Comunicação entre containers utilizando redes Docker;
* Orquestração de múltiplos serviços;
* Dependências entre microsserviços;
* Inicialização automatizada do ambiente;
* Importância do Docker Compose antes da migração para Kubernetes.

---

# Próxima etapa

Com todo o ambiente funcionando localmente, iniciou-se o provisionamento da infraestrutura em nuvem utilizando a AWS.

A primeira etapa foi a criação do cluster Kubernetes através do Amazon Elastic Kubernetes Service (Amazon EKS), que será responsável por executar os microsserviços em ambiente de produção.
