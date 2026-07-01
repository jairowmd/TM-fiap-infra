# Automação Docker

## Objetivo

Durante o desenvolvimento do projeto foram criados scripts PowerShell para automatizar todo o processo de construção e publicação das imagens Docker dos microsserviços.

Essa automação elimina tarefas repetitivas, reduz erros manuais e aproxima o fluxo de trabalho das práticas utilizadas em ambientes DevOps.

---

# Fluxo da Automação

```text
login-aws-academy.ps1
        │
        ▼
docker-login.ps1
        │
        ▼
build-images.ps1
        │
        ▼
push-images.ps1
        │
        ▼
Amazon ECR
        │
        ▼
Amazon EKS
```

---

# Scripts

## login-aws-academy.ps1

Configura as credenciais temporárias fornecidas pela AWS Academy.

Essas credenciais ficam disponíveis apenas durante a sessão atual do PowerShell.

> **Importante**
>
> Este script **não deve ser enviado ao GitHub**, pois contém credenciais temporárias da AWS.

---

## docker-login.ps1

Realiza a autenticação do Docker junto ao Amazon Elastic Container Registry (Amazon ECR).

Após sua execução, o Docker poderá enviar imagens para os repositórios do Amazon ECR.

---

## build-images.ps1

Constrói automaticamente as imagens Docker de todos os microsserviços utilizando seus respectivos Dockerfiles.

Microsserviços:

- auth-service
- flag-service
- targeting-service
- evaluation-service
- analytics-service

Durante a execução, o script:

- percorre automaticamente todos os microsserviços;
- executa o `docker build`;
- valida erros de execução;
- interrompe o processo em caso de falha.

---

## push-images.ps1

Responsável por publicar automaticamente todas as imagens Docker no Amazon ECR.

Durante sua execução, o script:

- cria a tag da imagem para o repositório do Amazon ECR (`docker tag`);
- publica a imagem (`docker push`);
- valida erros de execução;
- interrompe o processo em caso de falha.

---

# Fluxo completo

```text
Código Fonte
      │
      ▼
Dockerfile
      │
      ▼
docker build
      │
      ▼
Imagem Docker Local
      │
      ▼
docker tag
      │
      ▼
Imagem preparada para o Amazon ECR
      │
      ▼
docker push
      │
      ▼
Amazon ECR
      │
      ▼
Amazon EKS
      │
      ▼
Pods Kubernetes
```

---

# Benefícios

A utilização dos scripts proporcionou diversas vantagens:

- automação do processo de build;
- automação da publicação das imagens;
- redução de erros manuais;
- padronização do fluxo de deploy;
- facilidade para reproduzir o ambiente;
- maior produtividade durante o desenvolvimento.

---

# Próxima etapa

Após publicar todas as imagens no Amazon ECR, o próximo passo consiste na implantação dos microsserviços no Amazon EKS utilizando recursos do Kubernetes, como Deployments, Services, ConfigMaps e Secrets.