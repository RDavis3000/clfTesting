param vnetName string = 'vn-clftest'
param location string = resourceGroup().location
param securityGroupName string = 'sg-clftest'
param subnetName string = 'sn-clftest'
param vmName string = 'vm-cftest'
param appGatewayName string = 'ag-clftest'
param envName string = 'dev'
param vaultName string = 'kv-clftest'
param keyName string = 'sslkey'

@description('The JsonWebKeyType of the key to be created.')
@allowed([
  'EC'
  'EC-HSM'
  'RSA'
  'RSA-HSM'
])
param keyType string = 'RSA'

@description('The permitted JSON web key operations of the key to be created.')
param keyOps array = [
'decrypt'
'encrypt'
'import'
'release'
'sign'
'unwrapKey'
'verify'
'wrapKey'
]

@description('The size in bits of the key to be created.')
param keySize int = 2048

@description('The JsonWebKeyCurveName of the key to be created.')
@allowed([
  ''
  'P-256'
  'P-256K'
  'P-384'
  'P-521'
])
param curveName string = 'P-521'

var keyVaultSecretsUserRoleDefinitionId = '4633458b-17de-408a-b874-0445c86b69e6'
var keyVaultAdminRoleDefinitionId='00482a5a-887f-4fb3-b363-3b7fe8e74483'
var appGatewaySubnetName = 'sn-${appGatewayName}'

resource userIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'id-kv-${envName}'
  location: location
}

resource vault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: vaultName
  location: location
  properties: {
    accessPolicies:[]
    enableRbacAuthorization: true
    enableSoftDelete: false
    enabledForDeployment: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: true
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

resource kvRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(keyVaultAdminRoleDefinitionId,userIdentity.id,vault.id)
  scope: vault
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', keyVaultAdminRoleDefinitionId)
    principalId: userIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}


resource key 'Microsoft.KeyVault/vaults/keys@2022-07-01' = {
  parent: vault
  name: keyName
  properties: {
    kty: keyType
    keyOps: keyOps
    keySize: keySize
    curveName: curveName
    attributes:{
      enabled:true
      exportable:false
    }
    }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      } 
      {
        name: appGatewaySubnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }  
    ]
  }
}

resource securityGroup 'Microsoft.Network/networkSecurityGroups@2022-07-01'={
name: securityGroupName
location:location
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'nic-${vmName}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipcfg-${vmName}'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId(resourceGroup().name, 
            'Microsoft.Network/virtualNetworks/subnets', 
            virtualNetwork.name ,
            subnetName)
          }
        }
      }
    ]
  }
}

resource ubuntuVM 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Basic_A0'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'        
        name: 'dsk-os-${vmName}'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'       
        }
        diskSizeGB: 30
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId(resourceGroup().name,'Microsoft.Network/networkInterfaces','nic-${vmName}')
        }
      ]
    }
    osProfile:{
      computerName:vmName
      adminUsername:'jeepers'
      adminPassword:'creepersA@3'
      linuxConfiguration:{      
        disablePasswordAuthentication:false       
      }
    }
    // diagnosticsProfile: {
    //   bootDiagnostics: {
    //     enabled: true
    //     storageUri: 'storageUri'
    //   }
    // }
  }
}

resource appGateway 'Microsoft.Network/applicationGateways@2022-07-01' = {
  name: appGatewayName
  location:location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userIdentity.id}': {}
    }
  }
  properties:{
    sku:{
      name:'WAF_v2'
      tier:'WAF_v2'
    }
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 2
    }    
    gatewayIPConfigurations:[
      {
        name:'appgatewayipconfig'
        properties:{
          subnet:{
            id:resourceId('Microsoft.Network/virtualNetworks/subnets',vnetName,appGatewaySubnetName)
          }
        }
      }
    ]        
    frontendIPConfigurations:[
      {
        name:'appgatewaypublicipconfig'
        properties:{
          subnet:{
            id:resourceId('Microsoft.Network/virtualNetworks/subnets',vnetName,appGatewaySubnetName)
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
      {
        name: 'port_443'
        properties: {
          port: 443
        }
      }      
    ]    
    backendAddressPools: [
      {
        name: 'myBackendPool'
        properties: {}
      }
    ]    
    sslCertificates:[
      {
        name:'wildcard.climatefriendlytest.com'
        properties:{             
          keyVaultSecretId:'https://${vaultName}.vault.azure.net/secrets/${keyName}'
        }
      }
    ]
    httpListeners:[
      {
        name: 'ag_cc_80_${envName}_listener'
        properties: {
          protocol: 'Http'
          hostName: 'creditcounter-${envName}.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'appgatewaypublicipconfig')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'port_80')
          }          
        }
      }      
      {
        name: 'ag_cc_${envName}_listener'
        properties: {
          protocol: 'Https'
          hostName: 'creditcounter-${envName}.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'appgatewaypublicipconfig')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'port_443')
          }              
          sslCertificate:{
            id:  resourceId('Microsoft.Network/applicationGateways/sslCertificates',appGatewayName,'wildcard.climatefriendlytest.com')
          }          
        }
      }           
    ]
  }
}



