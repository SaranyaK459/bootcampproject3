environment = "dev"

vnet_cidr_prefix = {
  dev     = "10.10.0.0/16"
  staging = "10.20.0.0/16"
  prod    = "10.30.0.0/16"
}

subnet1_cidr_prefix = {
  dev     = "10.10.1.0/24"
  staging = "10.20.1.0/24"
  prod    = "10.30.1.0/24"
}

vm_name = {
  dev     = "dev-windows-vm"
  staging = "staging-windows-vm"
  prod    = "prod-windows-vm"
}

admin_username = {
  dev     = "devuser"
  staging = "staguser"
  prod    = "produser"
}

admin_password = {
  dev     = "DevP@ssword1!"
  staging = "StagingP@ssword2!"
  prod    = "ProdP@ssword3!"
}

resource_group_name = {
  dev     = "dev-vm-rg"
  staging = "staging-vm-rg"
  prod    = "prod-vm-rg"
}

location = {
  dev     = "canadacentral"
  staging = "canadacentral"
  prod    = "canadacentral"
}

# Add other variables as needed for your configuration, following the same pattern
