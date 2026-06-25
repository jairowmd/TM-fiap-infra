# Amazon EKS - Provisionamento do Cluster Kubernetes

## Objetivo

Após validar toda a aplicação localmente utilizando Docker e Docker Compose, o próximo passo foi preparar a infraestrutura em nuvem para hospedar os microsserviços.

Para isso foi utilizado o **Amazon Elastic Kubernetes Service (EKS)**, serviço gerenciado da AWS responsável por executar e orquestrar aplicações conteinerizadas utilizando Kubernetes.

Nesta etapa foi criado o cluster Kubernetes que será responsável por hospedar toda a arquitetura da aplicação ToggleMaster.

---

# O que é Kubernetes?

Kubernetes é uma plataforma de orquestração de containers criada para automatizar a implantação, escalabilidade e gerenciamento de aplicações distribuídas.

Enquanto o Docker é responsável por criar e executar containers, o Kubernetes é responsável por administrar esses containers em um ambiente de produção.

Entre suas principais responsabilidades estão:

* Implantar aplicações;
* Escalar serviços automaticamente;
* Reiniciar containers em caso de falha;
* Distribuir aplicações entre diferentes servidores;
* Gerenciar comunicação entre microsserviços.

Neste projeto, o Kubernetes será responsável por executar os cinco microsserviços da aplicação.

---

# O que é o Amazon EKS?

O Amazon Elastic Kubernetes Service (EKS) é o serviço gerenciado de Kubernetes da AWS.

Ao utilizar o EKS, não é necessário instalar ou administrar manualmente os componentes principais do Kubernetes.

A AWS gerencia automaticamente o Control Plane, permitindo que o foco permaneça na aplicação e na infraestrutura de suporte.

---

# Arquitetura do Cluster

```text
                        Amazon EKS

                 ┌──────────────────────┐
                 │     Control Plane    │
                 │   (Gerenciado AWS)   │
                 └──────────┬───────────┘
                            │
                            │
                   ┌────────▼────────┐
                   │  Node Group     │
                   └────────┬────────┘
                            │
                            ▼
                     EC2 t3.micro
                            │
                            ▼
                     Kubernetes Pods
```

Nesta etapa ainda não existem Pods executando aplicações.

Foi criada apenas a infraestrutura que receberá os microsserviços nas próximas fases.

---

# Componentes do Cluster

## Control Plane

O Control Plane é o cérebro do Kubernetes.

Ele é responsável por tomar decisões sobre todo o cluster.

Entre suas funções estão:

* Agendar Pods;
* Monitorar a saúde do cluster;
* Controlar Deployments;
* Gerenciar a API do Kubernetes.

No Amazon EKS, todo o Control Plane é administrado pela AWS.

---

## Worker Node

O Worker Node é o servidor responsável por executar os containers.

No projeto foi criado um Managed Node Group contendo uma instância EC2.

É nesse servidor que os Pods serão executados.

---

## Node Group

Um Node Group é um conjunto de máquinas EC2 gerenciadas pelo Amazon EKS.

Sua principal função é fornecer capacidade computacional para o cluster.

Foi criado um Managed Node Group com Auto Scaling habilitado.

Configuração utilizada:

* Mínimo: 1 nó
* Desejado: 1 nó
* Máximo: 2 nós

Essa configuração foi escolhida considerando as limitações de recursos do AWS Academy.

---

# Configurações utilizadas

| Configuração  | Valor              |
| ------------- | ------------------ |
| Cluster       | tm-fiap-cluster    |
| Kubernetes    | 1.35               |
| Região        | us-east-1          |
| IAM Role      | LabRole            |
| Endpoint      | Public and Private |
| Auto Mode     | Desabilitado       |
| Node Group    | tm-nodegroup       |
| Instância     | t3.micro           |
| Desired Nodes | 1                  |
| Minimum Nodes | 1                  |
| Maximum Nodes | 2                  |

---

# Add-ons instalados

Durante a criação do cluster foram utilizados os componentes essenciais do Kubernetes.

### CoreDNS

Responsável pela resolução de nomes entre os microsserviços.

Permite que um serviço encontre outro utilizando apenas seu nome.

---

### kube-proxy

Gerencia o tráfego de rede entre Pods e Services dentro do cluster.

---

### Amazon VPC CNI

Integra a rede do Kubernetes com a VPC da AWS, permitindo que cada Pod receba um endereço IP válido dentro da rede.

---

### Metrics Server

Responsável pela coleta de métricas de CPU e memória dos Pods.

Essas informações serão utilizadas futuramente pelo Horizontal Pod Autoscaler (HPA) para aumentar ou reduzir automaticamente a quantidade de réplicas dos microsserviços.

---

# Decisões de arquitetura

## Utilização da LabRole

Como o projeto foi desenvolvido no ambiente AWS Academy, foi utilizada a IAM Role disponibilizada pelo laboratório (`LabRole`), conforme recomendado pelo Tech Challenge.

---

## EKS Auto Mode desabilitado

O Auto Mode foi desabilitado para permitir maior controle sobre a criação e configuração do Managed Node Group.

Essa abordagem também evita limitações relacionadas às permissões do ambiente AWS Academy.

---

## Instância t3.micro

Foi utilizada uma instância EC2 do tipo `t3.micro` para reduzir o consumo de recursos do laboratório.

Embora não seja recomendada para ambientes produtivos, ela atende aos objetivos acadêmicos do projeto e permite executar a aplicação durante os testes.

---

# Resultado obtido

Ao final desta etapa foi disponibilizado um cluster Kubernetes totalmente funcional contendo:

* 1 Cluster Amazon EKS;
* 1 Managed Node Group;
* 1 Worker Node;
* Add-ons essenciais do Kubernetes;
* Comunicação pronta para receber os microsserviços.

O ambiente encontra-se preparado para receber as imagens Docker que serão publicadas no Amazon Elastic Container Registry (ECR).

---

# O que aprendi nesta etapa

Durante esta fase foram consolidados os seguintes conceitos:

* Diferença entre Docker e Kubernetes;
* Função do Amazon EKS;
* O papel do Control Plane;
* Diferença entre Cluster, Node e Pod;
* Importância do Managed Node Group;
* Funcionamento do Auto Scaling;
* Papel dos Add-ons do Kubernetes;
* Como o Kubernetes prepara o ambiente para executar aplicações conteinerizadas.

---

# Próxima etapa

Com o cluster Kubernetes criado e operacional, o próximo passo será configurar o **Amazon Elastic Container Registry (ECR)**.

O ECR será utilizado para armazenar as imagens Docker dos cinco microsserviços, permitindo que o Kubernetes realize o download dessas imagens durante a criação dos Pods.
