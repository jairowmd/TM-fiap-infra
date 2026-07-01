#########################################################
# Login Docker no Amazon ECR
#########################################################

# Carrega as credenciais da AWS Academy
. "$PSScriptRoot\login-aws-academy.ps1"

Write-Host ""
Write-Host "Realizando login no Amazon ECR..."
Write-Host ""

aws ecr get-login-password --region us-east-1 |
docker login `
--username AWS `
--password-stdin 106183805249.dkr.ecr.us-east-1.amazonaws.com

if ($LASTEXITCODE -eq 0) {

    Write-Host ""
    Write-Host "Login no Amazon ECR realizado com sucesso!"
}
else {

    Write-Host ""
    Write-Host "Erro ao realizar login no ECR."
}