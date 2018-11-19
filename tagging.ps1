# This script clears all tags within a subscription (i.e. tags associated with
# resource groups as well as those associated with the resources within the groups)

$resourcegroups = @()
$resourcesinrg = @()

 # list all resource groups, in a subscription
 Write-Host "List of Resource Groups: " -ForegroundColor Cyan

$resourcegroups = Get-AzureRmResourceGroup | Select-Object ResourceGroupName, Tags

# remove all tags from all the resource groups within a subscription
foreach ($rg in $resourcegroups) {

    # remove all tags from resource group
    Set-AzureRmResourceGroup -Name $rg.ResourceGroupName -Tag @{}

    # resources within a specific resource group
    Write-Host "Resources under $($rg.ResourceGroupName) resource group: " -ForegroundColor Cyan
    
    $resourcesinrg = Get-AzureRmResource -ResourceGroupName $rg.ResourceGroupName | Select-Object ResourceId

    # loop through all resources in a resource group to remove all associated tags
    foreach($res in $resourcesinrg) {
      Set-AzureRmResource -ResourceId $res.ResourceId -Tag @{} -Force
    }
  }

