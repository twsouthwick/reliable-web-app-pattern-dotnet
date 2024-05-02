param([switch]$isProd = $false)

Write-Host "IsProd: $isProd"

import-module az.resources
connect-azaccount -UseDeviceAuthentication
$AZURE_SUBSCRIPTION_ID = "6ad866ae-f77e-4d58-8f02-a00a75a0e21b"
Set-AzContext -SubscriptionId $AZURE_SUBSCRIPTION_ID

azd auth login
azd env new "tasou-rwa-$(Get-date -format "MMddHHmm")"
azd env set AZURE_SUBSCRIPTION_ID $AZURE_SUBSCRIPTION_ID

azd env set AZURE_LOCATION uksouth

if ($isProd) {
    azd env set ENVIRONMENT prod
    azd env set AZURE_SECONDARY_LOCATION northeurope
    azd provision
}else{    
    azd up
}