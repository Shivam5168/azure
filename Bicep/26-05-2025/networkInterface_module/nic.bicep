param nicLocation string
param subnetIds array

resource networkInterfaces 'Microsoft.Network/networkInterfaces@2024-05-01' = [for (subnetId, i) in subnetIds: {
  name: 'nic-${i}'
  location: nicLocation
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig-${i}'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          primary: i == 0
        }
      }
    ]
  }
}]

output nicIds array = [for (subnetId, i) in subnetIds: resourceId('Microsoft.Network/networkInterfaces', 'nic-${i}')]
