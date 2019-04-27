echo "Creating VNEt in East US"
az group deployment create --name NEWVNET --resource-group RG-2019GAB --template-file ./newvnet/azuredeploy.json
