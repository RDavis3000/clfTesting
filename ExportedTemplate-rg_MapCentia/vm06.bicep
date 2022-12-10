param virtualMachines_CFR_AZU_APP06_name string = 'CFR-AZU-APP06'
param disks_CFR_AZU_APP06_disk1_572d4bcdba444e97af391e8cbb4a556b_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_MapCentia/providers/Microsoft.Compute/disks/CFR-AZU-APP06_disk1_572d4bcdba444e97af391e8cbb4a556b'
param networkInterfaces_cfr_azu_app06824_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_MapCentia/providers/Microsoft.Network/networkInterfaces/cfr-azu-app06824'

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
          id: disks_CFR_AZU_APP06_disk1_572d4bcdba444e97af391e8cbb4a556b_externalid
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
          id: networkInterfaces_cfr_azu_app06824_externalid
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