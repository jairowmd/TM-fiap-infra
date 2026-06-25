# Docker - Conteinerização dos Microsserviços

## Objetivo

A primeira etapa do projeto consistiu em conteinerizar todos os microsserviços da aplicação ToggleMaster, permitindo que cada serviço fosse executado de forma isolada, reproduzível e independente do sistema operacional do desenvolvedor.

A utilização do Docker garante que o ambiente de desenvolvimento seja idêntico ao ambiente de execução, eliminando problemas relacionados à instalação de dependências ou diferenças entre sistemas operacionais.

---

# O que é Docker?

Docker é uma plataforma de conteinerização que permite empacotar uma aplicação juntamente com todas as suas dependências, bibliotecas e configurações em uma imagem.

Essa imagem pode ser executada em qualquer ambiente que possua Docker instalado, garantindo consistência entre desenvolvimento, testes e produção.

Diferentemente de máquinas virtuais, os containers compartilham o kernel do sistema operacional, tornando sua execução muito mais leve e rápida.

---

# Por que utilizamos Docker neste projeto?

O Tech Challenge possui cinco microsserviços desenvolvidos em linguagens diferentes.

Cada microsserviço possui suas próprias dependências e configurações.

Sem Docker seria necessário instalar manualmente:

* Python
* Go
* PostgreSQL
* Redis
* DynamoDB Local

Além de configurar todas as variáveis de ambiente individualmente.

Com Docker, cada serviço possui seu próprio ambiente isolado.

---

# Arquitetura da Conteinerização

```text
                        Docker

      ┌────────────────────────────────────┐
      │                                    │
      │  auth-service                      │
      │  Dockerfile                        │
      │                                    │
      └────────────────────────────────────┘

      ┌────────────────────────────────────┐
      │                                    │
      │  flag-service                      │
      │  Dockerfile                        │
      │                                    │
      └────────────────────────────────────┘

      ┌────────────────────────────────────┐
      │                                    │
      │ targeting-service                  │
      │ Dockerfile                         │
      │                                    │
      └────────────────────────────────────┘

      ┌────────────────────────────────────┐
      │                                    │
      │ evaluation-service                 │
      │ Dockerfile                         │
      │                                    │
      └────────────────────────────────────┘

      ┌────────────────────────────────────┐
      │                                    │
      │ analytics-service                  │
      │ Dockerfile                         │
      │                                    │
      └────────────────────────────────────┘
```

Cada microsserviço possui seu próprio Dockerfile, responsável por gerar sua imagem Docker de forma independente.

---

# Estrutura do projeto

```text
TM-fiap-infra/

├── analytics-service/
│   └── Dockerfile
│
├── auth-service/
│   └── Dockerfile
│
├── evaluation-service/
│   └── Dockerfile
│
├── flag-service/
│   └── Dockerfile
│
├── targeting-service/
│   └── Dockerfile
│
└── docker-compose.yml
```

---

# Estratégia adotada

Foi criado um Dockerfile específico para cada microsserviço.

Essa abordagem oferece vantagens importantes:

* Isolamento das dependências;
* Build independente de cada aplicação;
* Facilidade para manutenção;
* Escalabilidade individual dos serviços;
* Compatibilidade com Kubernetes.

Cada imagem poderá ser publicada individualmente no Amazon ECR durante as próximas etapas do projeto.

---

# Fluxo de construção das imagens

```text
Código-fonte

        │

Dockerfile

        │

docker build

        │

Imagem Docker

        │

docker run

        │

Container
```

O Dockerfile funciona como uma receita de construção da imagem.

Após o comando `docker build`, é gerada uma imagem contendo toda a aplicação e suas dependências.

Essa imagem pode ser executada quantas vezes forem necessárias através de containers.

---

# Benefícios obtidos

A utilização do Docker proporcionou:

* Padronização do ambiente de desenvolvimento;
* Facilidade para execução dos microsserviços;
* Isolamento entre aplicações;
* Reprodutibilidade do ambiente;
* Base para implantação no Kubernetes.

Além disso, essa etapa foi fundamental para permitir a publicação das imagens no Amazon Elastic Container Registry (ECR), utilizado posteriormente pelo cluster Kubernetes.

---

# Tecnologias utilizadas

* Docker
* Dockerfile
* Docker Engine

---

# O que aprendi nesta etapa

Durante esta etapa foram consolidados os seguintes conceitos:

* Diferença entre imagem e container;
* Estrutura e finalidade de um Dockerfile;
* Processo de build de uma imagem Docker;
* Execução de containers;
* Benefícios da conteinerização em arquiteturas de microsserviços;
* Importância do Docker como base para utilização do Kubernetes.

---

# Próxima etapa

Após a criação dos Dockerfiles individuais, o próximo passo foi integrar todos os microsserviços utilizando um único arquivo **docker-compose.yml**, permitindo inicializar todo o ambiente local com um único comando.
