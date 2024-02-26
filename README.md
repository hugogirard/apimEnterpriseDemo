# Enterprise Demo APIM

## GitHub Secrets

| Secret Name | Description |
| ----------- | ----------- |
| AZURE_CREDENTIALS | Azure Service Principal credentials |
| AZURE_SUBSCRIPTION | Azure Subscription ID |
| LOCATION | Azure Region where the resource will be deployed |
| PUBLISHER_EMAIL | Email of admin for APIM |
| PUBLISHER_NAME | Name of the organization for Dev Portal |
| CUSTOM_DOMAIN_NAME | Custom domain name for APIM for the DNS Azure Private Zone.  Needs to match with your SSL certificate for example (contoso.com) |

## Certificate

Run the script let's encrypt

## Upload cert

Upload the certificate to the Key Vault and give access to APIM MSI

Next configure your custom domain and create 3 new secrets

| Secret Name | Description |
| API_HOSTNAME | Custom domain name for APIM Gateway |
| DEV_PORTAL_HOSTAME | Custom domain name for APIM Developer Portal |
| MANAGEMENT_HOSTNAME | Custom domain name for APIM Management Plane |
| SECRET_CERT_LINK | Secret link to the certificate in the Key Vault |