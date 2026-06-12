1 - Criado o dockerfile e documentado

O dockerfile monta a imagem do python e executa o codigo

---------------------------------------------------------------------------

2 - Criado o dockercompose

O Docker Compose executa a imagem do banco de dados 

---------------------------------------------------------------------------

Extras

- Werkzeug==2.2.2 # -> adicionado para por erro ao compilar no requirements.txt
- Toda vez que ligar o pc subir o compose - # docker-compose up -d
- docker ps - para listar os containers
- docker logs + container (auth-service) - para verificar log de erros   

------------------------------------------------------------------------
teste da flag

curl -v -X POST http://localhost:8002/flags \
-H "Content-Type: application/json" \
-H "Authorization: Bearer tm_key_f1a8a2caf5596f322fdbf4e19e69d98c8773490efc4ee371ee76a34c037f185b" \
-d '{"name":"teste","description":"teste","is_enabled":true}'