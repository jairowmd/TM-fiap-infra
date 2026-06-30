# Amazon ElastiCache (Redis) - Camada de Cache da Aplicação

> **Fase do Projeto:** Infraestrutura
>
> **Tecnologia:** Amazon ElastiCache for Redis
>
> **Objetivo:** Provisionar uma camada de cache em memória para o microsserviço `evaluation-service`.
>
> **Pré-requisitos:** Amazon EKS, Amazon ECR e Amazon RDS configurados.
>
> **Próxima etapa:** Amazon DynamoDB

---

# Objetivo

Após provisionar a infraestrutura Kubernetes (Amazon EKS), o registro de imagens (Amazon ECR) e os bancos relacionais (Amazon RDS), foi necessário disponibilizar um serviço de cache para atender ao **evaluation-service**.

Para isso foi utilizado o **Amazon ElastiCache for Redis**, fornecendo uma camada de armazenamento em memória extremamente rápida para reduzir a latência das consultas e melhorar o desempenho da aplicação.

---

# O que é o Amazon ElastiCache?

O Amazon ElastiCache é um serviço gerenciado da AWS para bancos de dados em memória.

Neste projeto foi utilizado o mecanismo **Redis**, amplamente utilizado em arquiteturas modernas para armazenar informações temporárias e acelerar o processamento das aplicações.

Diferentemente de um banco relacional, o Redis mantém os dados em memória (RAM), permitindo tempos de resposta extremamente baixos.

---

# Por que utilizar Redis?

Em aplicações distribuídas, algumas informações são consultadas repetidamente.

Consultar o banco de dados a cada requisição aumenta a latência e gera carga desnecessária.

O Redis atua como uma camada intermediária:

```text
Aplicação

      │

      ▼

Redis (Cache)

      │

Encontrou?

 ┌───────────┐
 │    Sim    │────────► Retorna imediatamente
 └───────────┘

      │

      ▼

Banco de Dados

      │

      ▼

Grava no Cache

      │

      ▼

Retorna ao usuário
```

Essa estratégia reduz significativamente o tempo de resposta da aplicação.

---

# Arquitetura

O Amazon ElastiCache será utilizado pelo **evaluation-service**.

```text
                 Amazon EKS

                       │

               evaluation-service

                       │

                       ▼

              Amazon ElastiCache

                   Redis 7.1
```

---

# Papel do Redis na Arquitetura

O Redis foi escolhido para armazenar informações temporárias utilizadas pelo processo de avaliação das Feature Flags.

Por utilizar armazenamento em memória, o Redis oferece:

- baixa latência;
- alta performance;
- respostas rápidas;
- menor carga sobre os bancos relacionais.

---

# Recurso Provisionado

Foi criado um cache Redis denominado:

| Recurso | Nome |
|----------|------|
| Redis | evaluation-redis |

---

# Configuração utilizada

| Configuração | Valor |
|--------------|-------|
| Engine | Redis OSS |
| Versão | Redis 7.1 |
| Nome | evaluation-redis |
| Network | IPv4 |
| VPC | Default VPC |
| Availability Zones | us-east-1a e us-east-1c |
| Criptografia em repouso | AWS Managed KMS |
| Criptografia em trânsito | Habilitada |
| Security Group | Default |

---

# Decisões de Arquitetura

## Redis Serverless

Foi utilizada a modalidade **Serverless**, permitindo que a AWS gerencie automaticamente a infraestrutura do cache.

Essa abordagem elimina a necessidade de administrar instâncias EC2 ou configurar clusters manualmente.

---

## Criptografia

Foram mantidas as configurações padrão da AWS:

- Criptografia em repouso utilizando AWS Managed KMS.
- Criptografia em trânsito habilitada.

Mesmo em ambiente de laboratório, essas configurações seguem boas práticas de segurança.

---

## Availability Zones

O Redis foi provisionado utilizando múltiplas Availability Zones da região **us-east-1**, aumentando a disponibilidade do serviço.

Em ambientes produtivos, essa configuração contribui para maior resiliência contra falhas de infraestrutura.

---

# Onde este serviço se encaixa na arquitetura?

| Serviço AWS | Consumido por | Finalidade |
|-------------|---------------|------------|
| Amazon ElastiCache (Redis) | evaluation-service | Armazenamento temporário de dados em memória para acelerar consultas |

---

# Comparação entre PostgreSQL e Redis

| PostgreSQL | Redis |
|------------|-------|
| Persistente | Em memória |
| Dados relacionais | Chave/Valor |
| Mais lento | Muito rápido |
| Armazena dados definitivos | Armazena dados temporários |
| Utilizado para persistência | Utilizado para cache |

---

# Benefícios obtidos

A utilização do Amazon ElastiCache proporcionou:

- redução da latência da aplicação;
- armazenamento temporário em memória;
- menor carga sobre os bancos relacionais;
- integração nativa com a AWS;
- gerenciamento totalmente automatizado.

---

# O que aprendi nesta etapa

Durante esta etapa foram consolidados os seguintes conceitos:

- funcionamento do Redis;
- diferença entre cache e banco de dados;
- armazenamento em memória;
- baixa latência;
- integração do Redis com Kubernetes;
- utilização do Amazon ElastiCache Serverless.

---

# Perguntas que podem surgir em uma entrevista

### O que é o Redis?

Redis é um banco de dados em memória utilizado principalmente como camada de cache para acelerar aplicações.

---

### Qual a diferença entre Redis e PostgreSQL?

O PostgreSQL armazena dados permanentemente em disco.

O Redis mantém dados temporários em memória, oferecendo respostas muito mais rápidas.

---

### Por que utilizar Amazon ElastiCache?

Porque a AWS gerencia toda a infraestrutura do Redis, eliminando tarefas como instalação, atualização, monitoramento e administração do ambiente.

---

### Quando utilizar Redis?

Quando a aplicação necessita acessar frequentemente informações temporárias com baixa latência, reduzindo consultas repetidas ao banco de dados principal.

---

# Integração com a arquitetura completa

```text
                        Amazon EKS

                             │

        ┌───────────────┬───────────────┬────────────────┐

        │               │               │

   auth-service    flag-service   targeting-service

        │               │               │

        ▼               ▼               ▼

     Amazon RDS     Amazon RDS     Amazon RDS

                             │

                             ▼

                    evaluation-service

                             │

                             ▼

                  Amazon ElastiCache

                         Redis
```

---

# Próxima etapa

Com a camada de cache concluída, o próximo passo será provisionar o **Amazon DynamoDB**, utilizado pelo **analytics-service** para armazenar dados em um banco NoSQL totalmente gerenciado pela AWS.