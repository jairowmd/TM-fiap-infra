# from escolhe a base da imagem para etapa do build no caso a imagem do GO
FROM golang:1.21 AS builder

# trabalhando dentro do /app do container e criando esse diretorio para organização
WORKDIR /app

# Copia os arquivos de dependência
COPY go.mod go.sum ./

# baixa antes de copiar tudo para o diretorio de execução
RUN go mod download

# Copiar todos os arquivos do projeto - O primeiro . → refere-se ao diretório atual da sua máquina (onde está o projeto auth-service). 
# O segundo . → refere-se ao diretório de trabalho dentro do container (que você definiu antes com WORKDIR /app).
COPY . .

# É o comando do Go que compila o código-fonte e gera um binário executável.
# Ele lê o main.go (ou o pacote principal) e transforma em um programa pronto para rodar.
#  -o  Define o nome do binário gerado.
# . (ponto final) Indica o diretório atual como fonte do código.
RUN go mod tidy && go build -o evaluation-service .

# Expor a porta configurada
EXPOSE 8004

# Comando para rodar o serviço
CMD [ "./evaluation-service" ]