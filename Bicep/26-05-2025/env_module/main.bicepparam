using 'main.bicep'

param vnetName = 'az-vnet-001-bicep'
param vmName = 'az-vm-001-bicep'
param vmSize = 'Standard_A2_v2'
param osComputerName = 'vmOSUser'
param osAdminUserName = 'Shivam'
@secure()
param osAdminPassword = 'Shivam@123456789'
param subnets = [
  {
    Name: 'snet-vm'
    addressPrefix: '10.0.1.0/24'
  }
  {
    Name: 'snet-db'
    addressPrefix: '10.0.2.0/24'
  }
]
