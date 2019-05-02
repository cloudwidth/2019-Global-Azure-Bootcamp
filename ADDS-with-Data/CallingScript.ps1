break

# Shout out to @GoateePFE for laying the groundwork for this 
# @GoateePFE: Shout out to @brwilkinson for assistance with some of this.


# Install the Azure AZ Powershell modules from PowerShell Gallery
# Takes a while to install 28 modules
# Follow the instructions at the URL below if you do not already have the module installed on your workstation
'https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-1.8.0'

# Authenticate to your Azure account
Login-AzAccount

# Set the context to the appropriate Azure Subscription either by the subscription name or Id
Set-AzContext -SubscriptionName "MyMSDNSubscription"
Set-AzContext -SubscriptionName "00000000-0000-0000-0000-000000000000"

# Adjust the 'yourname' part below to something unique for you.
# Set the location to the Azure Region you want to deploy resources to
$URI       = 'https://raw.githubusercontent.com/cloudwidth/2019-Global-Azure-Bootcamp/master/ADDS-with-Data/azuredeploy.json'
$Location  = 'South Central US'
$namePrefix = 'yourname'                    ### cannot start with numbers, cannot be more than 11 characters - vmnaes will be vm+$NamePrefix+DC (i.e. vmMyVMNameDC)
$rgname    = ($namePrefix + '-rg')
$addnsName = ($namePrefix).ToLower()            ### Used for the public DNS name of the VM being deployed.  


# Check that the public dns $addnsName is available
if (Test-AzDnsAvailability -DomainNameLabel $addnsName -Location $Location)
{ 'Available' } else { 'Taken. addnsName must be globally unique.' }


# Create the new resource group. Runs quickly.
New-AzResourceGroup -Name $rgname -Location $Location

# Parameters for the template and configuration
$MyParams = @{
    location              = $Location
    domainName            = ($namePrefix + ".com")       ### The maximum length is 15 characters
    addnsName             = $addnsName
    namePrefix            = $namePrefix
   }

# Splat the parameters on New-AzureRmResourceGroupDeployment  
$SplatParams = @{
    TemplateUri             = $URI 
    ResourceGroupName       = $rgname 
    TemplateParameterObject = $MyParams
    Name                    = ($namePrefix + 'Forest')
   }

# This takes ~30 minutes
# One prompt for the domain admin password
New-AzResourceGroupDeployment @SplatParams -Verbose

# Find the VM IP and FQDN
$PublicAddress = (Get-AzPublicIpAddress -ResourceGroupName $rgname)[0]
$IP   = $PublicAddress.IpAddress
$FQDN = $PublicAddress.DnsSettings.Fqdn

# RDP either way
Start-Process -FilePath mstsc.exe -ArgumentList "/v:$FQDN"
Start-Process -FilePath mstsc.exe -ArgumentList "/v:$IP"

# Login as:  alpineskihouse\adadministrator
# Use the password you supplied at the beginning of the build.

# Explore the Active Directory domain:
#  Recycle bin enabled
#  Admin tools installed
#  Five new OU structures
#  Users and populated groups within the OU structures
#  Users root container has test users and populated test groups

# Delete the entire resource group when finished
Remove-AzResourceGroup -Name $rgname -Force -Verbose
