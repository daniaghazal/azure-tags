# apply tagging topology from CSV file on resource groups and on resources within

Param (
    $filepath
)
$csv = import-csv $filepath

# applying tags on resource groups
foreach ($item in $csv) {
    Set-AzureRmResourceGroup -Name $item.ResourceGroupName -Tag @{environment="$($item.environment)";
    applicationname="$($item.applicationname)"; applicationid="$($item.applicationid)"; costcenter="$($item.costcenter)";
    businessunit="$($item.businessunit)"}
}

$resourcegroups = @()
$resourcesinrg = @()

Write-Host "Resource Groups" -ForegroundColor green
$resourcegroups = Get-AzureRmResourceGroup | Select-Object ResourceGroupName, Tags

# applying tags on all resources in a resource group
foreach ($rg in $resourcegroups) {
    if ($rg.Tags -ne $null) {
        Write-Host "Resources under $($rg.ResourceGroupName) resource group: " -ForegroundColor Cyan
        $resourcesinrg = Get-AzureRmResource -ResourceGroupName $rg.ResourceGroupName

        foreach ($res in $resourcesinrg) {
            Set-AzureRmResource -ResourceId $res.ResourceId -Tag $rg.Tags -Force
        }
    }
}
