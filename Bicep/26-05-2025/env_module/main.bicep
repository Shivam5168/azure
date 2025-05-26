param location string = resourceGroup().location
param vnetName string
param subnets array
param vmName string
param vmSize string
param osComputerName string
param osAdminUserName string
@secure()
param osAdminPassword string

module vnet_module '../virtualNetwork_module/vn.bicep' = {
  name:'vnet_module'
  params:{
    location: location
    vnetName: vnetName
    subnets: subnets
  }
}

module nic_module '../networkInterface_module/nic.bicep' = {
  name: 'nic_module'
  params:{
    nicLocation: location
    subnetIds: vnet_module.outputs.subnetIds
  }
}

module vm_module '../virtualMachineModule/vm.bicep' = {
  name: 'vm_module'
  params: {
    vmlocation: location
    vmName: vmName
    vmSize: vmSize
    nicID: nic_module.outputs.nicIds
    osComputerName: osComputerName
    osAdminUserName: osAdminUserName
    osAdminPassword: osAdminPassword
  }
}
