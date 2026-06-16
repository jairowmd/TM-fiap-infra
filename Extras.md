Ordem recomendada de testes com Docker

auth-service → valida autenticação.

flag-service → cria e gerencia flags.

targeting-service → aplica regras de segmentação.

evaluation-service → avalia decisões em tempo real.

analytics-service → coleta e armazena eventos.

------------------------------------------------------------------------------------------------------------
Toda vez que você reinicia o PC, os containers que estavam rodando não sobem automaticamente. O Docker não mantém os serviços ativos após desligar a máquina, então você precisa rodar novamente docker-compose up -d:

- Toda vez que ligar o pc subir o compose - # docker-compose up -d


- docker ps - para listar os containers
- docker logs + container (auth-service) - para verificar log de erros
- docker-compose down - derrubar  containers do compose

reconstrua a imagem:

docker-compose build
docker-compose up -d


Criei a rede shared_net para os hosts se comunicarem
- docker network create shared_net  