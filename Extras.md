Toda vez que você reinicia o PC, os containers que estavam rodando não sobem automaticamente. O Docker não mantém os serviços ativos após desligar a máquina, então você precisa rodar novamente docker-compose up -d:

- Toda vez que ligar o pc subir o compose - # docker-compose up -d


- docker ps - para listar os containers
- docker logs + container (auth-service) - para verificar log de erros   
