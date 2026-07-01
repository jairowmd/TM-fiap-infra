# Amazon SQS

## Objetivo

O Amazon Simple Queue Service (SQS) é o serviço de mensageria utilizado para desacoplar a comunicação entre os microsserviços da aplicação.

Neste projeto, o `evaluation-service` publica mensagens na fila, enquanto o `analytics-service` consome essas mensagens e grava os eventos no Amazon DynamoDB.

Essa arquitetura aumenta a resiliência da aplicação, permitindo que os serviços funcionem de forma independente.

---

# Arquitetura

```
evaluation-service

        │

        ▼

Amazon SQS

analytics-events-queue

        │

        ▼

analytics-service

        │

        ▼

Amazon DynamoDB
```

---

# Recurso criado

| Propriedade | Valor |
|-------------|-------|
| Serviço | Amazon SQS |
| Tipo | Standard |
| Nome da fila | analytics-events-queue |
| Região | us-east-1 |
| Criptografia | SSE-SQS |

---

# Tipo da fila

Foi utilizada uma fila do tipo:

```text
Standard Queue
```

### Motivos

- Alta escalabilidade
- Alta disponibilidade
- Melhor desempenho
- Totalmente compatível com a aplicação

Como não existe necessidade de processamento exatamente na ordem de envio das mensagens, uma fila Standard atende perfeitamente ao projeto.

---

# Configuração utilizada

| Configuração | Valor |
|--------------|-------|
| Queue Type | Standard |
| Encryption | Amazon SQS managed key (SSE-SQS) |
| Visibility Timeout | 30 segundos |
| Message Retention | 4 dias |
| Delivery Delay | 0 segundos |
| Maximum Message Size | 256 KB |

As demais configurações permaneceram com os valores padrão da AWS.

---

# Fluxo da aplicação

```
Usuário

      │

      ▼

evaluation-service

      │

Envia evento

      │

      ▼

analytics-events-queue

      │

Consome evento

      ▼

analytics-service

      │

Processa informações

      ▼

Amazon DynamoDB

ToggleMasterAnalytics
```

---

# Integração com a aplicação

O projeto utiliza a seguinte variável de ambiente:

```env
AWS_REGION=us-east-1

AWS_SQS_QUEUE=analytics-events-queue
```

Essa configuração será utilizada posteriormente durante o deploy no Kubernetes através de ConfigMaps e Secrets.

---

# Benefícios do uso do Amazon SQS

Durante o desenvolvimento foi possível compreender os seguintes conceitos:

- Comunicação assíncrona entre microsserviços;
- Desacoplamento entre aplicações;
- Maior tolerância a falhas;
- Escalabilidade horizontal;
- Processamento de eventos baseado em filas.

---

# Resultado

Ao final desta etapa foi criada a fila `analytics-events-queue`, responsável pela comunicação entre os microsserviços `evaluation-service` e `analytics-service`.

A infraestrutura AWS necessária para o projeto foi concluída com sucesso.

---

# Próxima etapa

Após finalizar toda a infraestrutura em nuvem, o próximo passo será publicar as imagens Docker no Amazon ECR e iniciar a implantação da aplicação no cluster Kubernetes (Amazon EKS).