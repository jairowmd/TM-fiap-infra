# from escolhe a base da imagem para etapa do build no caso a imagem do GO
FROM golang:1.25 AS builder

# trabalhando dentro do /app do container e criando esse diretorio para organização
WORKDIR /app

# Copiar todos os arquivos do projeto - O primeiro . → refere-se ao diretório atual da sua máquina (onde está o projeto auth-service). 
# O segundo . → refere-se ao diretório de trabalho dentro do container (que você definiu antes com WORKDIR /app).
COPY . .

# Instalar Dependencias
RUN go mod tidy

# É o comando do Go que compila o código-fonte e gera um binário executável.
# Ele lê o main.go (ou o pacote principal) e transforma em um programa pronto para rodar.
#  -o auth-service Define o nome do binário gerado.
# . (ponto final) Indica o diretório atual como fonte do código.
RUN go build -o auth-service .

# Expor a porta configurada
EXPOSE 8001

# Comando para rodar o serviço
CMD [ "./auth-service" ]