Break


#First Authenticate your PowerShell session to Azure
Connect-AzAccount

## 1. Get the Billing Account Name (Use this if you only have a single billing account)
$BillingAccountName = (Get-AzBillingAccount).Name

<#
#Use if you have more than one billing Account
$BillingAccountName = (Get-AzBillingAccount | Where-Object {$_.DisplayName -eq 'Your billing Account Display Name'}).Name
#>


## 2. Get the BillingProfile & BillingScope

# Two step approach (Use this if you only have a single billing profile and InvoiceSection)
$BillingProfileName = (Get-AzBillingProfile -BillingAccountName $BillingAccountName).Name
$BillingScope = (Get-AzInvoiceSection -BillingProfileName $BillingProfileName -BillingAccountName $BillingAccountName).Id

<#
#Oneliner (Advanced users only, you can use this if you only have a single billing profile and InvoiceSection))
$BillingScope = (Get-AzInvoiceSection -BillingProfileName ((Get-AzBillingProfile -BillingAccountName $BillingAccountName).Name) -BillingAccountName $BillingAccountName).Id
#>

<#
#Two Step Approach with filter (Use this if you have multiple billing profiles or Invoice Sections)

$BillingProfileName = (Get-AzBillingProfile -BillingAccountName $BillingAccountName | Where-Object {$_.DisplayName -eq 'Your Billing Profile Display Name'}).Name
$BillingScope = (Get-AzInvoiceSection -BillingProfileName $BillingProfileName -BillingAccountName $BillingAccountName | Where-Object {$_.DisplayName -eq 'Your Invoice Section Display Name'}).Id
#>

<#
#Oneliner with filter (advanced users only, you can use this if you have multiple billing profiles or Invoice Sections)
$BillingScope = (Get-AzInvoiceSection -BillingProfileName ((Get-AzBillingProfile -BillingAccountName $BillingAccountName | Where-Object {$_.DisplayName -eq 'Your Billing Profile Display Name'}).Name) -BillingAccountName $BillingAccountName | Where-Object {$_.DisplayName -eq 'Your Invoice Section Display Name'}).Id
#>

# Building a subscriptions array
$Subscriptions = @()

$Subscriptions += @{
    Name = 'Prod Subscription 1'
    Workload = 'Production'
}

$Subscriptions += @{
    Name = 'Prod Subscription 2'
    Workload = 'Production'
}

# Build a Parameters Object
$Parameters = @{subscriptions = $Subscriptions; billingScope = $BillingScope}

#Splatting parameters to make it more readable
$Params = @{
    ManagementGroupId = 'Corp'
    Templatefile = '.\main.bicep'
    TemplateParameterObject = $Parameters
    Location = 'WestEurope'
    Name = "Subdeploy_$(Get-Date -Format "MM-dd-yyyy_HH.mm")"
}

#Deploy the Subscriptions
New-AzManagementGroupDeployment @Params