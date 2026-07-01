# Automação do Projeto

## Objetivo

Durante o desenvolvimento deste projeto foram criados scripts PowerShell para automatizar as tarefas repetitivas de build, publicação das imagens Docker e implantação da aplicação no Kubernetes.

Essa abordagem reduz erros manuais, facilita novas implantações e aproxima o fluxo de trabalho das práticas utilizadas em equipes DevOps.

---

# Fluxo da Automação

```text
AWS Academy

↓

login-aws-academy.ps1

↓

docker-login.ps1

↓

build-images.ps1

↓

push-images.ps1

↓

deploy-all.ps1

↓

Amazon EKS
```

---

# Scripts

## login-aws-academy.ps1

Responsável por configurar as credenciais temporárias fornecidas pela AWS Academy.

Ao executar este script, a AWS CLI fica autenticada durante a sessão atual do PowerShell.

Executar:

```powershell
.\scripts\login-aws-academy.ps1
```

Resultado esperado:

```text
AWS Academy configurada com sucesso
```

---

## docker-login.ps1

Realiza a autenticação do Docker junto ao Amazon Elastic Container Registry (Amazon ECR).

Executar:

```powershell
.\scripts\docker-login.ps1
```

Resultado esperado:

```text
Login Succeeded
```

---

## build-images.ps1

Realiza automaticamente o build das imagens Docker de todos os microsserviços.

Microsserviços contemplados:

- auth-service
- flag-service
- targeting-service
- evaluation-service
- analytics-service

---

## push-images.ps1

Publica todas as imagens Docker construídas localmente para seus respectivos repositórios no Amazon ECR.

---

## deploy-all.ps1

Responsável por implantar toda a aplicação no cluster Kubernetes.

Entre os recursos implantados estão:

- Namespace
- ConfigMaps
- Secrets
- Deployments
- Services
- Ingress
- HPA

---

# Fluxo de utilização

Sempre que um novo laboratório da AWS Academy for iniciado, os scripts devem ser executados na seguinte ordem:

```powershell
.\scripts\login-aws-academy.ps1

.\scripts\docker-login.ps1

.\scripts\build-images.ps1

.\scripts\push-images.ps1

.\scripts\deploy-all.ps1
```

---

# Benefícios

A utilização desses scripts trouxe diversas vantagens durante o desenvolvimento do projeto:

- Automatização de tarefas repetitivas;
- Redução de erros manuais;
- Padronização do processo de deploy;
- Facilidade para reproduzir o ambiente;
- Maior produtividade.

---

# Próxima etapa

Após concluir a automação, inicia-se a publicação das imagens Docker no Amazon ECR e a implantação da aplicação no Amazon EKS.