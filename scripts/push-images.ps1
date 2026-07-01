#########################################################
# 4 - Push das Imagens para o Amazon ECR
#########################################################

Clear-Host

Write-Host ""
Write-Host "========================================="
Write-Host " Push das Imagens para o Amazon ECR"
Write-Host "========================================="
Write-Host ""

# ID da conta AWS Academy
$accountId = "106183805249"

# Região AWS
$region = "us-east-1"

# Registry do Amazon ECR
$registry = "$accountId.dkr.ecr.$region.amazonaws.com"

# Lista dos microsserviços
$services = @(
    "auth-service",
    "flag-service",
    "targeting-service",
    "evaluation-service",
    "analytics-service"
)

# Percorre todos os microsserviços
foreach ($service in $services)
{
    # Monta o endereço completo da imagem
    $image = "$registry/$($service):latest"

    Write-Host ""
    Write-Host "-----------------------------------------"
    Write-Host "Publicando imagem: $service"
    Write-Host "Destino: $image"
    Write-Host "-----------------------------------------"

    # Cria a tag da imagem para o Amazon ECR
    docker tag `
        "$($service):latest" `
        $image

    if ($LASTEXITCODE -ne 0)
    {
        Write-Host ""
        Write-Host "Erro ao criar a tag da imagem: $service"
        exit
    }

    # Envia a imagem para o Amazon ECR
    docker push $image

    if ($LASTEXITCODE -ne 0)
    {
        Write-Host ""
        Write-Host "Erro ao enviar a imagem: $service"
        exit
    }

    Write-Host ""
    Write-Host "Imagem '$($service):latest' enviada com sucesso!"
}

Write-Host ""
Write-Host "========================================="
Write-Host "Todas as imagens foram enviadas para o Amazon ECR!"
Write-Host "========================================="