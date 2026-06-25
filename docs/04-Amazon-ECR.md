# Amazon ECR - Registro de Imagens Docker

> **Fase do Projeto:** Infraestrutura
> **Tecnologia:** Amazon Elastic Container Registry (ECR)
> **Objetivo:** Armazenar as imagens Docker dos microsserviços para utilização pelo Amazon EKS.
> **Pré-requisitos:** Docker, Docker Compose e Cluster Amazon EKS criados.
> **Próxima etapa:** Provisionamento dos bancos de dados na AWS.

---

# Objetivo

Após a criação do cluster Kubernetes, foi necessário disponibilizar as imagens Docker em um repositório acessível pela AWS.

Para isso foi utilizado o **Amazon Elastic Container Registry (ECR)**, serviço responsável por armazenar imagens Docker de forma segura e integrada ao Amazon EKS.

Cada microsserviço possui seu próprio repositório no ECR, permitindo versionamento e implantação independente.

---

# O que é o Amazon ECR?

O Amazon Elastic Container Registry (ECR) é um serviço de registro de imagens Docker totalmente gerenciado pela AWS.

Seu principal objetivo é armazenar imagens de containers que posteriormente serão utilizadas por serviços como:

* Amazon EKS
* Amazon ECS
* AWS Lambda (Container Images)

No contexto deste projeto, o EKS utilizará o ECR como fonte oficial das imagens Docker dos microsserviços.

---

# Por que utilizar o ECR?

Durante o desenvolvimento, as imagens Docker existem apenas na máquina do desenvolvedor.

Essas imagens não podem ser acessadas diretamente pelo cluster Kubernetes.

O Amazon ECR resolve esse problema, funcionando como um repositório central de imagens.

Fluxo simplificado:

```text
Notebook

│

docker build

│

Imagem Docker

│

docker push

│

Amazon ECR

│

Amazon EKS

│

Pod
```

---

# Arquitetura

```text
                     Desenvolvedor

                           │

                    docker build

                           │

                           ▼

                    Docker Image

                           │

                    docker push

                           │

                           ▼

                  Amazon ECR Repository

                           │

                  docker pull (automático)

                           │

                           ▼

                     Amazon EKS

                           │

                           ▼

                    Kubernetes Pod
```

---

# Repositórios criados

Foi criado um repositório privado para cada microsserviço.

| Repositório        |
| ------------------ |
| auth-service       |
| flag-service       |
| targeting-service  |
| evaluation-service |
| analytics-service  |

Essa abordagem permite que cada serviço evolua de forma independente.

---

# Estratégia adotada

Cada microsserviço possui:

* Dockerfile próprio;
* Imagem Docker independente;
* Repositório dedicado no Amazon ECR.

Essa organização facilita:

* Deploy independente;
* Versionamento individual;
* Escalabilidade dos serviços;
* Atualização sem impacto nos demais microsserviços.

---

# Image Tags

As imagens Docker podem possuir diferentes versões através das **Tags**.

Exemplos:

```text
auth-service:latest

auth-service:v1.0.0

auth-service:v1.1.0
```

Durante o desenvolvimento foi utilizada inicialmente a tag:

```text
latest
```

Em ambientes produtivos recomenda-se utilizar versionamento semântico para facilitar rollback e rastreabilidade das implantações.

---

# Configuração utilizada

| Configuração         | Valor      |
| -------------------- | ---------- |
| Visibilidade         | Private    |
| Image Tag Mutability | Mutable    |
| Encryption           | AES-256    |
| Scan                 | Padrão AWS |

---

# Decisões de arquitetura

## Repositórios separados

Cada microsserviço recebeu seu próprio repositório.

Essa estratégia evita acoplamento entre aplicações e facilita o ciclo de vida independente de cada serviço.

---

## Repositórios privados

Todos os repositórios foram criados como privados.

Somente serviços autorizados da AWS poderão acessar as imagens.

---

## Mutable

Foi utilizada a opção **Mutable**, permitindo substituir a imagem utilizando a mesma tag durante o desenvolvimento.

Essa configuração simplifica testes e atualizações frequentes.

Para ambientes produtivos, recomenda-se utilizar imagens imutáveis (Immutable) associadas a versões específicas.

---

# Fluxo completo da imagem

```text
Código Fonte

      │

Dockerfile

      │

docker build

      │

Imagem Docker

      │

docker push

      │

Amazon ECR

      │

Deployment Kubernetes

      │

docker pull

      │

Pod
```

O Kubernetes nunca utiliza diretamente o código-fonte da aplicação.

Ele sempre executa uma imagem Docker previamente armazenada no Amazon ECR.

---

# Benefícios obtidos

A utilização do Amazon ECR proporcionou:

* Centralização das imagens Docker;
* Integração nativa com o Amazon EKS;
* Maior segurança através de repositórios privados;
* Facilidade para versionamento das aplicações;
* Possibilidade de atualização independente de cada microsserviço.

---

# O que aprendi nesta etapa

Durante esta fase foram consolidados os seguintes conceitos:

* Diferença entre Docker Hub e Amazon ECR;
* Funcionamento de um Container Registry;
* Fluxo de publicação de imagens Docker;
* Conceito de Tags em imagens Docker;
* Integração entre Amazon ECR e Amazon EKS;
* Importância do versionamento das imagens.

---

# Próxima etapa

Com o cluster Kubernetes pronto e as imagens disponíveis no Amazon ECR, o próximo passo será provisionar os serviços de persistência utilizados pela aplicação.

Serão criados:

* Amazon RDS PostgreSQL;
* Amazon ElastiCache Redis;
* Amazon DynamoDB;
* Amazon SQS.
