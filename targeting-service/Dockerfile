# from escolhe a base da imagem para etapa do build no caso a imagem do python
FROM python:3.9 AS builder

# trabalhando dentro do /app do container e criando esse diretorio para organização
WORKDIR /app

# Copiar todos os arquivos do projeto - O primeiro . → refere-se ao diretório atual da sua máquina (onde está o projeto). 
# O segundo . → refere-se ao diretório de trabalho dentro do container (que você definiu antes com WORKDIR /app).
COPY . .

# Instala dependências
# --no-cache-dir: instala os pacotes e descarta os arquivos temporários, deixando a imagem enxuta.
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta do serviço
EXPOSE 8003

# Comando padrão ao iniciar o container
# Gunicorn (Green Unicorn) é um servidor WSGI para aplicações Python.
# Ele funciona como um “intermediário” entre sua aplicação Flask/Django e o mundo externo.
#  Isso diz ao Docker: “quando o container iniciar, rode o Gunicorn e sirva minha aplicação Flask (app.py com objeto app) na porta definida”.
CMD [ "gunicorn", "--bind", "0.0.0.0:8003", "app:app" ]