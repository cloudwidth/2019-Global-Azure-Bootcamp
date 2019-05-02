# Choose an Azure region different from the region you used in Part 1 creating the initial Domain Controller
location = "eastus"

# A new resource group will be created for your domain controllers.  Provide the new RG name below
new_dc_resourcegroup = "yourname-rg2"

# Provide the name of the resource group where your target vnet resides
target_vnet_resourcegroup = "yourname-rg"

# Provide the name of the target vnet
target_vnet = "yournameVNet"

# Provide the name of the target subnet
target_subnet = "yourname-Subnet"

# Provide a valid VM name prefix.  A number will be appended beginning with 1 and increasing based on the count value below
vmname_prefix = "yourname"

# Provide the name of the existing AD domain you wish to join
addomain = "yourname.com"

# Leave this as is
admin_username = "adadministrator"

# Provide the password for the domain admin username that you entered during Part 1
admin_password = "2019GABdemo"

# Provide the same value below as you did for admin_password above
safemode_password = "2019GABdemo"

# Leave the value below unless you manually modified your AD Sites on your own
adsitename = "Default-First-Site-Name"

# Provide the count of how many new domain controllers you want to deploy
count = 1
