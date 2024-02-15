# Generate let's encrypt certificate in Azure
param(
    [Parameter(Mandatory = $true)]
    [string]$certNames,
    [Parameter(Mandatory = $true)]
    [string]$acmeContact,
    [Parameter(Mandatory = $true)]
    [string]$aZSubscriptionId,
    [Parameter(Mandatory = $true)]
    [string]$aZTenantId,
    [Parameter(Mandatory = $true)]
    [string]$aZAppUsername,
    [Parameter(Mandatory = $true)]
    [string]$aZAppPassword,
    [Parameter(Mandatory = $true)]
    [string]$pfxPassword = $true
)

$azParams = @{
    AZSubscriptionId=$aZSubscriptionId
    AZTenantId=$aZTenantId
    AZAppUsername=$aZAppUsername
    AZAppPasswordInsecure=$aZAppPassword
}

try {
    
    $workingDirectory = Join-Path -Path "." -ChildPath "pa"
    New-Item -Path $workingDirectory -ItemType Directory | Out-Null

    $env:POSHACME_HOME = $workingDirectory
    Import-Module Posh-ACME -Force

    # Configure Posh-ACME account
    $account = Get-PAAccount
    if (-not $account) {
        # New account
        $account = New-PAAccount -Contact $AcmeContact -AcceptTOS
    }
    elseif ($account.contact -ne "mailto:$AcmeContact") {
        # Update account contact
        Set-PAAccount -ID $account.id -Contact $AcmeContact
    }

    Set-PAServer LE_PROD

    New-PACertificate $certNames -Plugin Azure -PluginArgs $azParams -PfxPass $pfxPassword -Force    

}
catch {
    Write-Host "An error occurred:"
    Write-Host $_
}
