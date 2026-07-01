#########################################################
# 3 - Build das Imagens Docker
#########################################################

# Limpa a tela (opcional)
Clear-Host

Write-Host ""
Write-Host "========================================="
Write-Host " Build das Imagens Docker"
Write-Host "========================================="
Write-Host ""

# Lista dos microsserviços que possuem Dockerfile
$services = @(
    "auth-service",
    "flag-service",
    "targeting-service",
    "evaluation-service",
    "analytics-service"
)

# Percorre cada microsserviço da lista
foreach ($service in $services)
{

    Write-Host ""
    Write-Host "Service = '$service'"
    Write-Host "Tag = '$($service):latest'"
    Write-Host "-----------------------------------------"
    Write-Host "Construindo imagem: $service"
    Write-Host "-----------------------------------------"

    # Executa o docker build
    docker build `
        -t "$($service):latest" `
        "./$service"

    # Verifica se o comando anterior executou com sucesso
    if ($LASTEXITCODE -ne 0)
    {

        Write-Host ""
        Write-Host "Erro ao construir a imagem do serviço: $service"

        # Encerra imediatamente o script
        exit

    }

    Write-Host ""
    Write-Host "Imagem '$($service):latest' criada com sucesso!"
}

Write-Host ""
Write-Host "========================================="
Write-Host "Todas as imagens foram construídas!"
Write-Host "========================================="