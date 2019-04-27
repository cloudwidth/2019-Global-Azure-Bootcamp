location = "eastus"

# A new resource group will be created for your domain controllers.  Provide the new RG name below
new_dc_resourcegroup = "RG-2019GAB2"

# Provide the name of the resource group where your target vnet resides
target_vnet_resourcegroup = "RG-2019GAB"

# Provide the name of the target vnet
target_vnet = "GAB2019DemoVNet"

# Provide the name of the target subnet
target_subnet = "GAB2019Demo-Subnet"

# Provide a valid VM name prefix.  A number will be appended beginning with 1 and increasing based on the count value below
vmname_prefix = "GAB2019DCvm"

# Provide the name of the existing AD domain you wish to join
addomain = "2019GABdemo.com"

# Provide the domain admin username of the existing domain
admin_username = "adadministrator"

# Provide the password for the domain admin username above
admin_password = "2019GABdemo"

# Provide the safemode password for the exsting AD domain
safemode_password = "2019GABdemo"

# Provide the AD SIte name you wish to have the new domain controller(s) joined to
adsitename = "Default-First-Site-Name"

# Provide the count of how many new domain controllers you want to deploy
count = 1
