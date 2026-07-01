# Kubernetes - Conceitos Fundamentais

## Objetivo

Antes de iniciar a criação dos manifestos Kubernetes, é importante compreender os principais conceitos da plataforma.

Assim como o Docker utiliza imagens e containers, o Kubernetes possui recursos próprios responsáveis por orquestrar aplicações containerizadas.

Compreender esses conceitos facilita a criação dos arquivos YAML e ajuda a entender como o cluster toma decisões automaticamente.

---

# O que é Kubernetes?

O Kubernetes (K8s) é uma plataforma de orquestração de containers criada para automatizar a implantação, escalabilidade e gerenciamento de aplicações.

Enquanto o Docker é responsável por executar containers, o Kubernetes é responsável por administrar esses containers em um ou mais servidores.

Entre suas principais funcionalidades estão:

- gerenciamento automático de containers;
- escalabilidade horizontal;
- balanceamento de carga;
- recuperação automática de falhas;
- gerenciamento de configuração;
- gerenciamento de segredos;
- atualização sem indisponibilidade (Rolling Update).

---

# Fluxo Geral

Durante este projeto, o fluxo da aplicação será:

```text
Código Fonte
        │
        ▼
Docker Build
        │
        ▼
Imagem Docker
        │
        ▼
Amazon ECR
        │
        ▼
Amazon EKS
        │
        ▼
Deployment
        │
        ▼
Pod
        │
        ▼
Container
        │
        ▼
Aplicação
```

---

# Principais Recursos do Kubernetes

## Namespace

É uma divisão lógica dentro do cluster Kubernetes.

Seu objetivo é organizar recursos, separar ambientes e facilitar o gerenciamento de aplicações.

---

## Deployment

É o recurso responsável por gerenciar os Pods.

O Deployment descreve como um Pod deve ser criado e garante que a quantidade desejada permaneça em execução.

Entre suas responsabilidades estão:

- criar Pods;
- substituir Pods com falha;
- realizar atualizações;
- controlar a quantidade de réplicas.

---

## Pod

É a menor unidade executável do Kubernetes.

Um Pod pode conter um ou mais containers que compartilham rede, armazenamento temporário e ciclo de vida.

Na maioria dos microsserviços, cada Pod contém apenas um container.

---

## Container

É a instância em execução de uma imagem Docker.

O container executa efetivamente a aplicação desenvolvida.

---

## Service

É responsável por fornecer um endereço estável para acesso aos Pods.

Como Pods podem ser recriados constantemente, seus endereços IP mudam.

O Service resolve esse problema criando um ponto de acesso fixo.

---

## ConfigMap

Armazena configurações da aplicação que não são sensíveis.

Exemplos:

- portas;
- URLs;
- nomes de banco;
- parâmetros da aplicação.

---

## Secret

Armazena informações sensíveis.

Exemplos:

- senhas;
- tokens;
- chaves de acesso;
- credenciais de banco de dados.

---

## Ingress

Permite publicar aplicações HTTP e HTTPS para acesso externo.

Além disso, possibilita utilizar um único endereço para diversas aplicações através de regras de roteamento.

---

## HPA (Horizontal Pod Autoscaler)

Permite aumentar ou reduzir automaticamente a quantidade de Pods de acordo com métricas como utilização de CPU ou memória.

---

# Hierarquia dos Recursos

```text
Deployment
        │
        ▼
ReplicaSet
        │
        ▼
Pod
        │
        ▼
Container
        │
        ▼
Aplicação
```

---

# Conceitos importantes

## Kubernetes é Declarativo

O Kubernetes trabalha utilizando o conceito de **estado desejado**.

Ao invés de informar passo a passo como criar uma aplicação, descrevemos em arquivos YAML como desejamos que o ambiente permaneça.

Exemplo:

```yaml
replicas: 3
```

Estamos informando que desejamos três Pods em execução.

Caso algum Pod falhe, o Kubernetes automaticamente criará outro para manter esse estado.

---

## Infraestrutura como Código (IaC)

Todos os recursos Kubernetes podem ser descritos através de arquivos YAML.

Esses arquivos podem ser armazenados em um repositório Git, permitindo versionamento, auditoria e reprodução completa do ambiente.

---

# Próximos passos

Após compreender esses conceitos, iniciaremos a criação dos manifestos Kubernetes na seguinte ordem:

1. Namespace
2. Deployment
3. Service
4. ConfigMap
5. Secret
6. Ingress
7. HPA
8. Deploy da aplicação