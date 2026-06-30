# Amazon RDS - Persistência dos Microsserviços

> **Fase do Projeto:** Infraestrutura
>
> **Tecnologia:** Amazon Relational Database Service (Amazon RDS)
>
> **Objetivo:** Provisionar bancos de dados PostgreSQL independentes para os microsserviços que necessitam de persistência relacional.
>
> **Pré-requisitos:** Amazon EKS e Amazon ECR configurados.
>
> **Próxima etapa:** Amazon ElastiCache (Redis)

---

# Objetivo

Após criar o cluster Kubernetes (Amazon EKS) e o repositório de imagens (Amazon ECR), foi necessário disponibilizar bancos de dados para os microsserviços responsáveis pelo armazenamento de informações persistentes.

Para isso foi utilizado o **Amazon Relational Database Service (RDS)** com o mecanismo **PostgreSQL**, criando uma instância dedicada para cada microsserviço que necessita de banco de dados relacional.

Essa abordagem segue uma das principais boas práticas da arquitetura de microsserviços: **Database per Service**.

---

# O que é o Amazon RDS?

O Amazon Relational Database Service (Amazon RDS) é um serviço gerenciado da AWS para bancos de dados relacionais.

Em vez de instalar e administrar manualmente um servidor PostgreSQL em uma máquina virtual, a AWS assume diversas responsabilidades operacionais, como:

- Instalação do banco de dados;
- Aplicação de atualizações;
- Monitoramento da instância;
- Gerenciamento do armazenamento;
- Recuperação automática durante eventos de manutenção.

Dessa forma, a equipe pode concentrar seus esforços no desenvolvimento da aplicação, reduzindo significativamente a carga operacional.

---

# Por que utilizar o Amazon RDS?

Neste projeto, o Amazon RDS oferece diversas vantagens:

- Banco de dados totalmente gerenciado;
- Alta disponibilidade (quando configurado);
- Facilidade de escalabilidade;
- Integração com outros serviços AWS;
- Monitoramento nativo;
- Administração simplificada.

Essas características tornam o Amazon RDS a escolha ideal para hospedar os bancos relacionais utilizados pelos microsserviços.

---

# Arquitetura de Persistência

Cada microsserviço é responsável pelos seus próprios dados.

```text
                  Kubernetes Cluster

      auth-service
             │
             ▼
        PostgreSQL
          auth-db

────────────────────────────────────

      flag-service
             │
             ▼
        PostgreSQL
          flag-db

────────────────────────────────────

   targeting-service
             │
             ▼
        PostgreSQL
       targeting-db
```

Essa separação reduz o acoplamento entre os serviços e permite que cada banco evolua de forma independente.

---

# Padrão de Arquitetura Aplicado

## Database per Service

Durante o desenvolvimento foi adotado o padrão **Database per Service**.

Nesse modelo, cada microsserviço possui seu próprio banco de dados, evitando dependências diretas entre diferentes componentes da aplicação.

Entre os principais benefícios dessa abordagem estão:

- Independência entre microsserviços;
- Redução do acoplamento;
- Maior facilidade para manutenção;
- Escalabilidade individual;
- Evolução independente do modelo de dados.

Esse padrão é amplamente utilizado em arquiteturas modernas baseadas em microsserviços.

---

# Bancos provisionados

Foram criadas três instâncias independentes do Amazon RDS PostgreSQL.

| Banco | Microsserviço |
|--------|---------------|
| auth-db | auth-service |
| flag-db | flag-service |
| targeting-db | targeting-service |

Cada banco possui seu próprio endpoint, credenciais e armazenamento.

---

# Configuração utilizada

| Configuração | Valor |
|--------------|-------|
| Engine | PostgreSQL |
| Ambiente | Development / Test |
| Disponibilidade | Single-AZ |
| Classe da Instância | db.t4g.micro |
| Armazenamento | SSD GP3 |
| Porta | 5432 |
| VPC | Default VPC |
| Acesso Público | Conforme necessidade do laboratório |

---

# Decisões de Arquitetura

## PostgreSQL

O PostgreSQL foi escolhido por ser o banco de dados utilizado pela aplicação original do projeto.

Além disso, é um banco relacional robusto, amplamente utilizado em ambientes corporativos e totalmente suportado pelo Amazon RDS.

---

## Single-AZ

Foi utilizada a configuração **Single Availability Zone**, adequada para ambientes de desenvolvimento e laboratório.

Essa configuração reduz o consumo de recursos e atende aos objetivos do Tech Challenge.

Em ambientes produtivos, recomenda-se utilizar **Multi-AZ**, garantindo maior disponibilidade da aplicação.

---

## Instâncias Independentes

Embora fosse possível utilizar um único banco contendo múltiplos schemas, optou-se pela criação de três instâncias distintas.

Essa abordagem reforça o isolamento entre os microsserviços e segue uma das principais recomendações para arquiteturas distribuídas.

---

# Integração com a Arquitetura

O Amazon RDS faz parte da camada de persistência da solução.

```text
                Amazon EKS

                     │

        ┌────────────┼────────────┐

        │            │            │

 auth-service   flag-service   targeting-service

        │            │            │

        ▼            ▼            ▼

    Amazon RDS   Amazon RDS   Amazon RDS
```

Cada microsserviço estabelece conexão apenas com seu respectivo banco de dados.

Não existe compartilhamento de dados entre os serviços.

---

# Benefícios obtidos

A utilização do Amazon RDS proporcionou:

- Persistência confiável dos dados;
- Administração simplificada do PostgreSQL;
- Separação entre os bancos dos microsserviços;
- Escalabilidade individual;
- Integração nativa com os demais serviços AWS.

---

# O que aprendi nesta etapa

Durante esta fase foram consolidados os seguintes conceitos:

- Funcionamento do Amazon RDS;
- Diferença entre banco autogerenciado e serviço gerenciado;
- Conceito de Database per Service;
- Importância do isolamento entre microsserviços;
- Diferença entre Single-AZ e Multi-AZ;
- Integração entre Kubernetes e bancos de dados relacionais.

---

# Perguntas que podem surgir em uma entrevista

### Por que utilizar três bancos de dados ao invés de apenas um?

Porque cada microsserviço deve possuir autonomia sobre seus próprios dados, reduzindo o acoplamento e permitindo evolução independente.

---

### Por que utilizar Amazon RDS ao invés de instalar PostgreSQL em uma EC2?

Porque o Amazon RDS reduz a carga operacional, oferecendo gerenciamento automático, monitoramento, armazenamento e manutenção da instância.

---

### Por que utilizar Single-AZ neste projeto?

Devido às limitações de recursos do ambiente AWS Academy e por se tratar de um ambiente de laboratório.

Em produção, recomenda-se utilizar Multi-AZ para garantir alta disponibilidade.

---

# Próxima etapa

Com a camada de persistência relacional concluída, o próximo passo será provisionar o **Amazon ElastiCache (Redis)**.

O Redis será utilizado pelo **evaluation-service**, fornecendo armazenamento em memória para operações que exigem alta performance e baixa latência.