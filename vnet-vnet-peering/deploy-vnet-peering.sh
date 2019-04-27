echo "Peering South Central US to East US"
az group deployment create --name PEERSCUS2EUS --resource-group RG-2019GAB --template-file ./peering/azuredeploy.scus2eus.json
echo "Peering East US to South Central US"
az group deployment create --name PEEREUS2SCUS --resource-group RG-2019GAB --template-file ./peering/azuredeploy.eus2scus.json