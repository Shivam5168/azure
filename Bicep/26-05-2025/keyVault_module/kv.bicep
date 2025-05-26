@description('Name of the Key Vault')
param keyVaultName string

@description('Location for the Key Vault')
param location string

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableRbacAuthorization: true
  }
}

resource usernameSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'adminUsername' 
  parent: keyVault      
  properties: {
    value: adminUsername
  }
}

resource passwordSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: 'adminPassword'
  parent: keyVault
  properties: {
    value: adminPassword
  }
}

output keyVaultId string = keyVault.id
output keyVaultName string = keyVault.name

