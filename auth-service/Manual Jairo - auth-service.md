🔹 Por que usar Dockerfile para apps Go
Compilação do código

O Go precisa compilar os arquivos .go em um binário.

O Dockerfile garante que isso aconteça dentro da imagem, sem depender da sua máquina local.

Dependências

O go.mod e go.sum listam as bibliotecas externas (como o pgx).

O Dockerfile roda go mod tidy ou go mod download para instalar tudo dentro da imagem.

Assim, qualquer pessoa que rodar sua imagem terá exatamente as mesmas dependências.

Portabilidade

Com o Dockerfile, você gera uma imagem que já contém o binário pronto.

Essa imagem pode ser levada para qualquer servidor, sem precisar instalar Go ou dependências lá.

Controle de build

Você pode otimizar a imagem (multi-stage build, reduzir tamanho, etc.).

Pode fixar a versão do Go (FROM golang:1.25) para garantir consistência.

🔹 Quando não precisa de Dockerfile
Para serviços prontos (Postgres, Redis, Nginx, etc.), basta usar image: no Compose.

Não há código seu para compilar, então não faz sentido escrever Dockerfile.

🔹 Melhor prática
O padrão em produção é:

Dockerfile → para sua aplicação (Go, Node, Python, etc.).

Compose/Kubernetes → para orquestrar sua aplicação junto com serviços externos (banco, cache, etc.).

Assim você separa responsabilidades:

Dockerfile = como construir a imagem da sua aplicação.

Compose = como rodar e conectar os serviços.


Primeiro se controi a imagem com o dokerfile e depois roda ela

1. Construir a imagem
No terminal, dentro da pasta onde está o Dockerfile:

bash
docker build -t auth-service .
-t auth-service dá um nome para a imagem.

O . indica que o contexto de build é o diretório atual (onde está o Dockerfile e o código).

Se tudo der certo, você verá no final algo como:
Successfully tagged auth-service:latest


docker build -t auth-service .

-----------------------------------------------------------------------------

2. Contruir o docker compose



-----------------------------------------------------------------------------

Apos subir o compose fazer os testes, fiz aqui e funcionou certinho

S C:\Users\Jairo\Desktop\github faculdade\ToggleMaster-fase2\auth-service> curl.exe -X POST http://localhost:8001/admin/keys ^  -H "Content-Type: application/json" ^  -H "Authorization: Bearer admin-secreto-123" ^  -d "{\"name\": \"meu-primeiro-servico\"}"                                                                                                                                                                                     
Corpo da requisição inválido
curl: (3) URL rejected: Bad hostname
curl: (3) URL rejected: Bad hostname
curl: (3) URL rejected: Bad hostname
curl: (3) URL rejected: Malformed input to a URL function
PS C:\Users\Jairo\Desktop\github faculdade\ToggleMaster-fase2\auth-service> Invoke-WebRequest -Uri "http://localhost:8001/admin/keys" `  -Method POST `  -Headers @{Authorization="Bearer admin-secreto-123"; "Content-Type"="application/json"} `  -Body '{"name": "meu-primeiro-servico"}'

Aviso de Segurança: Risco de Execução de Script
Invoke-WebRequest analisa o conteúdo da página da Web. O código de script na página pode ser executado durante a análise.
      AÇÃO RECOMENDADA:
      Use o parâmetro -UseBasicParsing para evitar a execução do código de script.

      Deseja continuar?
    
[S] Sim  [A] Sim para Todos  [N] Não  [T] Não para Todos  [U] Suspender  [?] Ajuda (o padrão é "N"): S


StatusCode        : 201
StatusDescription : Created
Content           : {"name":"meu-primeiro-servico","key":"tm_key_d1662f341a4da07bb5bacfc3be0c7ebe0e03b80501640cbd0ebb652290f2b81c","message":"Guarde esta chave com segurança! Você não poderá vê-la novamente."}
                    
RawContent        : HTTP/1.1 201 Created
                    Content-Length: 195
                    Content-Type: text/plain; charset=utf-8
                    Date: Sat, 06 Jun 2026 02:16:18 GMT
                    
                    {"name":"meu-primeiro-servico","key":"tm_key_d1662f341a4da07bb5bacfc3be0c7ebe...
Forms             : {}
Headers           : {[Content-Length, 195], [Content-Type, text/plain; charset=utf-8], [Date, Sat, 06 Jun 2026 02:16:18 GMT]}                                                                                              
Images            : {}                                                                                                                                                                                                     
InputFields       : {}                                                                                                                                                                                                     
Links             : {}                                                                                                                                                                                                     
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 195



PS C:\Users\Jairo\Desktop\github faculdade\ToggleMaster-fase2\auth-service> Invoke-WebRequest -Uri "http://localhost:8001/validate" `  -Headers @{Authorization="Bearer tm_key_d1662f341a4da07bb5bacfc3be0c7ebe0e03b80501640cbd0ebb652290f2b81c"} `  -Method GET                  

Aviso de Segurança: Risco de Execução de Script
Invoke-WebRequest analisa o conteúdo da página da Web. O código de script na página pode ser executado durante a análise.
      AÇÃO RECOMENDADA:
      Use o parâmetro -UseBasicParsing para evitar a execução do código de script.

      Deseja continuar?
    
[S] Sim  [A] Sim para Todos  [N] Não  [T] Não para Todos  [U] Suspender  [?] Ajuda (o padrão é "N"): S


StatusCode        : 200
StatusDescription : OK
Content           : {"message":"Chave válida"}
                    
RawContent        : HTTP/1.1 200 OK
                    Content-Length: 28
                    Content-Type: text/plain; charset=utf-8
                    Date: Sat, 06 Jun 2026 02:18:22 GMT
                    
                    {"message":"Chave válida"}
                    
Forms             : {}
Headers           : {[Content-Length, 28], [Content-Type, text/plain; charset=utf-8], [Date, Sat, 06 Jun 2026 02:18:22 GMT]}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 28



PS C:\Users\Jairo\Desktop\github faculdade\ToggleMaster-fase2\auth-service> 


