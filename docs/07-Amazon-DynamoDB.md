# Amazon DynamoDB

## Objetivo

O Amazon DynamoDB é o banco de dados NoSQL utilizado pelo **analytics-service** para armazenar eventos de utilização das Feature Flags.

Diferente dos bancos PostgreSQL utilizados pelos demais microsserviços, o DynamoDB oferece alta escalabilidade, baixa latência e gerenciamento totalmente serverless.

Neste projeto, o fluxo é:

```
evaluation-service
        │
        ▼
    Amazon SQS
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
| Serviço | Amazon DynamoDB |
| Tabela | ToggleMasterAnalytics |
| Região | us-east-1 |
| Classe | Standard |
| Capacity Mode | On-demand |

---

# Estrutura da tabela

## Table Name

```text
ToggleMasterAnalytics
```

## Partition Key

```text
event_id
```

Tipo:

```text
String
```

Não foi utilizada **Sort Key**, pois cada evento possui um identificador único (UUID).

---

# Capacity Mode

Foi escolhido o modo:

```text
On-demand
```

### Motivos

- Escalabilidade automática
- Não é necessário definir capacidade de leitura e escrita
- Ideal para ambientes de laboratório
- Menor complexidade de gerenciamento

---

# Estrutura dos dados

O `analytics-service` grava documentos semelhantes ao exemplo abaixo:

```json
{
  "event_id": "6fd67b7e-a6df-41d8-a8d0-14bb2ecfd0c4",
  "user_id": "user123",
  "flag_name": "new-home",
  "result": true,
  "timestamp": "2026-06-30T12:30:15Z"
}
```

Cada evento representa uma avaliação realizada pelo sistema de Feature Flags.

---

# Integração com o analytics-service

A aplicação utiliza as seguintes variáveis de ambiente:

```env
AWS_REGION=us-east-1
AWS_DYNAMODB_TABLE=ToggleMasterAnalytics
```

Essas variáveis serão configuradas posteriormente através de **ConfigMaps** e **Secrets** no Kubernetes.

---

# Fluxo da aplicação

```
Usuário

    │

    ▼

evaluation-service

    │

    ▼

Amazon SQS

    │

    ▼

analytics-service

    │

    ▼

Amazon DynamoDB

(ToggleMasterAnalytics)
```

---

# Resultado

Ao final desta etapa foi criada com sucesso uma tabela DynamoDB totalmente compatível com o código do `analytics-service`, pronta para receber os eventos processados pela aplicação.

---

# Aprendizados

Durante esta etapa foi possível compreender:

- Diferença entre bancos relacionais e NoSQL;
- Conceito de Partition Key;
- Modo de capacidade On-demand;
- Funcionamento básico do Amazon DynamoDB;
- Integração do DynamoDB com aplicações Python utilizando boto3;
- Armazenamento de eventos para aplicações distribuídas.

---

# Próxima etapa

Na próxima etapa será criado o **Amazon SQS**, responsável pela comunicação assíncrona entre os microsserviços `evaluation-service` e `analytics-service`.