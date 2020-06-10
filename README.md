# Automate Removal/Application of Azure Tags on Resource Groups and Resources

## Provided are two scripts:
- **removetags.ps1** - this script removes all azure tags from resources and resource groups within a given Azure subscription
- **applytags.ps1** - this script applies a specified set of tags from a CSV file to their associated resource groups, in addition to all resources within the resource group

## Steps:
1. **Remove all tags in a given subscription**
- Using Windows PowerShell, log into your specific Azure subscription by running
```
	Login-AzureRmAccount
	Select-AzureRmSubscription -Subscription "Your_Subscription_Name"	
```
- Run the script
```
	.\removetags.ps1
```

2. **Apply specified tags**
```
	.\applytags.ps1 "path_to_CSV_file"
```
where *path_to_CSV_file* looks something like this "C:\Users\...\taggingtopology.csv"
