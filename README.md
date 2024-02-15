# Enterprise Demo APIM

## GitHub Secrets

| Secret Name | Description |
| ----------- | ----------- |
| AZURE_CREDENTIALS | Azure Service Principal credentials |
| AZURE_SUBSCRIPTION | Azure Subscription ID |
| LOCATION | Azure Region where the resource will be deployed |
| PUBLISHER_EMAIL | Email of admin for APIM |
| PUBLISHER_NAME | Name of the organization for Dev Portal |

## Certificate

Run the script let's encrypt

## Upload cert

Upload the certificate to the Key Vault and give access to APIM MSI

Next configure your custom domain and create 3 new secrets

| Secret Name | Description |
