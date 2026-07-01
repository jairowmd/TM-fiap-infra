#########################################################
# 1- AWS Academy Login
#########################################################
# pegar na tela de iniciar os laboratórios de aprendizagem da AWS Academy
# AWS Details e clicar em show, as credencias so funcionam enquanto o academy estiver aberto
# Cole aqui as credenciais temporárias da AWS Academy

$Env:AWS_ACCESS_KEY_ID="ACCESS_KEY"

$Env:AWS_SECRET_ACCESS_KEY="SECRET_ACCESS"

$Env:AWS_SESSION_TOKEN="AWS_SESSION_TOKEN"

$Env:AWS_DEFAULT_REGION="us-east-1"

Write-Host ""
Write-Host "========================================="
Write-Host " AWS Academy configurada com sucesso"
Write-Host "========================================="
Write-Host ""

aws sts get-caller-identity

if ($LASTEXITCODE -eq 0) {

    Write-Host ""
    Write-Host "Autenticação realizada com sucesso!"
}
else {

    Write-Host ""
    Write-Host "Erro ao autenticar na AWS."
}