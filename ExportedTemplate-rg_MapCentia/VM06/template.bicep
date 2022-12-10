param virtualMachines_CFR_AZU_APP06_name string = 'CFR-AZU-APP06'
param networkInterfaces_cfr_azu_app06824_name string = 'cfr-azu-app06824'
param virtualNetworks_vn_cfr_azu_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_network/providers/Microsoft.Network/virtualNetworks/vn_cfr_azu'
param applicationGateways_ag_metabase_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_MapCentia/providers/Microsoft.Network/applicationGateways/ag_metabase'
param networkSecurityGroups_CFR_AZU_APP06_nsg_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_MapCentia/providers/Microsoft.Network/networkSecurityGroups/CFR-AZU-APP06-nsg'

resource networkInterfaces_cfr_azu_app06824_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: networkInterfaces_cfr_azu_app06824_name
  location: 'australiaeast'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_cfr_azu_app06824_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"e111bf8d-76de-4fc0-8276-b289fc66670f"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.1.19'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: '${virtualNetworks_vn_cfr_azu_externalid}/subnets/Server'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationGatewayBackendAddressPools: [
            {
              id: '${applicationGateways_ag_metabase_externalid}/backendAddressPools/devstage_backend'
            }
            {
              id: '${applicationGateways_ag_metabase_externalid}/backendAddressPools/fc_backend'
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_CFR_AZU_APP06_nsg_externalid
    }
    nicType: 'Standard'
  }
}

resource virtualMachines_CFR_AZU_APP06_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: virtualMachines_CFR_AZU_APP06_name
  location: 'australiaeast'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
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
        name: '${virtualMachines_CFR_AZU_APP06_name}_disk1_572d4bcdba444e97af391e8cbb4a556b'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_CFR_AZU_APP06_name}_disk1_572d4bcdba444e97af391e8cbb4a556b')
        }
        diskSizeGB: 30
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_CFR_AZU_APP06_name
      adminUsername: 'a-admin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_cfr_azu_app06824_name_resource.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}