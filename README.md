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
| DEV_PORTAL_FQDN | Developer Portal FQDN for example (dev.contoso.com) |
| GATEWAY_FQDN | Gateway FQDN  for example (api.contoso.com) |
| MANAGEMENT_FQDN | managementPortalFqdn (management.contoso.com) |

## Certificate

Run the script let's encrypt

## Upload cert

Upload the certificate to the Key Vault and give access to APIM MSI

Next configure your custom domain and create 3 new secrets

| Secret Name | Description |
