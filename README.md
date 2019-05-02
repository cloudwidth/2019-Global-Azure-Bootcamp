# 2019-Global-Azure-Bootcamp

## Prerequisites
- An Azure subscription (MSDN, trial, etc.)
- WMF 5.0 (or WMF 4.0 with PowerShellGet installed)

## Part 1: Use an ARM template to deploy a new Active Directory domain with sample data
Shout-out to @GoateePFE for the initial work on the code for Part 1.

Log into your Azure subscription and open a PowerShell cloud shell session.
Clone this repo down to your clouddrive.

Follow the instructions in .\ADDS-with-Data\CallingScript.ps1

Once the deployment completes, you can RDP into your new domain controller

## Part 2: Use an ARM template to create a new vnet in another region and peer with the vnet from Part 1

Switch your cloud shell session to Bash
Navigate to clouddrive/2019-Global-Azure-Bootcamp/vnet-vnet-peering
Execute the following shell scripts.
This process takes less than a minute for each shell script to execute

The first shell script uses the Azure CLI to create an ARM deployment to create the new vnet in the EAST US Region
sh deploy-new-vnet.sh

The second shell script uses the Azure CLI to create an ARM deployment to peer the new vnet with the existing vnet from Part 1
sh deploy-vnet-peering.sh

## Part 3: Use Terraform to deploy a new Active Directory domain controller in the new vnet from Part 1

Continue using or refresh your Bash cloud shell session
Navigate to clouddrive/2019-Global-Azure-Bootcamp/CreateADReplicaDC

Edit the CreateADReplicaDC.tfvars file.  Validate all values match as instructed in the file.

Initialize your terraform workspace to ensure you have the correct resources to use the AzureRM provider
terraform init

Validate your template by creating a terraform plan.  Ensure there are no errors returned
terraform plan --var-file="CreateADReplicaDC.tfvars"

Deploy your new Active Directory domain controller(s).  
This process takes about 15-20 minutes.
terraform apply --var-file="CreateADReplicaDC.tfvars"

You will be promted to type 'yes' to validate you wish to continue
Once your deployment completes, you can RDP into your new domain controllers from the one created in Part 1.
Check the AD Users & Computers MMC to view the new domain controllers in the "Domain Controllers" container in AD
