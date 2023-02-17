# This scripts delete instance of soft-deleted APIM

try {
    $token=(az account get-access-token --query accessToken --output tsv)
    $subscriptionId=(az account show --query id --output tsv)

    $url="https://management.azure.com/subscriptions/$subscriptionId/providers/Microsoft.ApiManagement/deletedservices?api-version=2021-08-01"

    $header = @{
        "Authorization"="Bearer $token"
    }

    $reponse = Invoke-WebRequest -Uri $url -Headers $header -Method 'Get'

    if ($reponse.StatusCode -ne 200) {
        throw "Error, statusCode: $response.StatusCode" 
    }

    foreach ($apim in ($reponse.Content | ConvertFrom-Json)) {
        Write-Output "Deleting $apim.name"
    }
    
}
catch {
    throw "Something happen"
}

