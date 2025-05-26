param vmName string 
param vmlocation string
param vmSize string
param osComputerName string
@secure()
param osAdminUserName string
@secure()
param osAdminPassword string
param nicID array

resource ubuntuVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: vmlocation
  properties: {
    hardwareProfile: {
      vmSize: vmSize 
    }
    osProfile: { 
      computerName: osComputerName   
      adminUsername: osAdminUserName 
      adminPassword: osAdminPassword 
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        name: 'osdisk-${vmName}'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        for (id, i) in nicID: {
          id: id
          properties:{primary: i == 0}
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}
