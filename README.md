# 2019-Global-Azure-Bootcamp

### Part 1: Use an ARM template to deploy a new Active Directory domain with sample data
### Shout-out to @GoateePFE for the initial work on the code for Part 1.

### Log into your Azure subscription and open a PowerShell cloud shell session.
### Clone this repo down to your clouddrive.

### Modify the below powershell code blocks as necessary and execute on the command line
### Adjust the 'yournamehere' part of these three strings to
### something unique for you.

    $URI       = 'https://raw.githubusercontent.com/cloudwidth/2019-Global-Azure-Bootcamp/master/ADDS-with-Data/azuredeploy.json'
    $Location  = 'South Central US'
    $rgname    = 'yournamehere'
    $namePrefix = 'yournamehere'                    ### cannot start with numbers
    $addnsName = ($namePrefix).ToLower()            ### Lowercase required

### Check that the public dns $addnsName is available

    if (Test-AzDnsAvailability -DomainNameLabel $addnsName -Location $Location)
    { 'Available' } else { 'Taken. addnsName must be globally unique.' }


### Create the new resource group. Runs quickly.
New-AzResourceGroup -Name $rgname -Location $Location

### Parameters for the template and configuration
$MyParams = @{
    location              = $Location
    domainName            = ($namePrefix + ".com")       ### The maximum length is 15 characters
    addnsName             = $addnsName
    namePrefix            = $namePrefix
   }

### Splat the parameters on New-AzureRmResourceGroupDeployment  
$SplatParams = @{
    TemplateUri             = $URI 
    ResourceGroupName       = $rgname 
    TemplateParameterObject = $MyParams
    Name                    = ($namePrefix + 'Forest')
   }

### Deploy the ARM templates with the PowerShell command below
### You will be prompted for the domain admin password (REMEMBER THIS FOR PART 3 BELOW)
### Default domain administrator username is 'adadministrator'
New-AzResourceGroupDeployment @SplatParams -Verbose

### Once the deployment completes, you can RDP into your new domain controller


# Part 2: Use an ARM template to create a new vnet in another region and peer with the vnet from Part 1

### Switch your cloud shell session to Bash
### Navigate to /2019-Global-Azure-Bootcamp/vnet-vnet-peering
### Execute the following shell scripts.
### This process takes less than a minute for each shell script to execute

### The first shell script uses the Azure CLI to create an ARM deployment to create the new vnet in the EAST US Region
sh deploy-new-vnet.sh

### The second shell script uses the Azure CLI to create an ARM deployment to peer the new vnet with the existing vnet from Part 1
sh deploy-vnet-peering.sh

# Part 3: Use Terraform to deploy a new Active Directory domain controller in the new vnet from Part 1

### Continue using or refresh your Bash cloud shell session
### Navigate to 2019-Global-Azure-Bootcamp/CreateADReplicaDC

### Edit the CreateADReplicaDC.tfvars file.  Validate all values match as instructed in the file.

### Initialize your terraform workspace to ensure you have the correct resources to use the AzureRM provider
terraform init

### Validate your template by creating a terraform plan.  Ensure there are no errors returned
terraform plan --var-file="CreateADReplicaDC.tfvars"

### Deploy your new Active Directory domain controller(s).  
### This process takes about 15-20 minutes.
terraform apply --var-file="CreateADReplicaDC.tfvars"

### You will be promted to type 'yes' to validate you wish to continue
### Once your deployment completes, you can RDP into your new domain controllers from the one created in Part 1.
### Check the AD Users & Computers MMC to view the new domain controllers in the "Domain Controllers" container in AD
