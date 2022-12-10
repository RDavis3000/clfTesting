param applicationGateways_agw_aks_test_scus_001_name string = 'agw-sample-dev-scus-001'
param virtualNetworks_vnet_dev_scus_001_externalid string = '/subscriptions/<SUB_ID>/resourceGroups/<RESOURCE_NAME>/providers/Microsoft.Network/virtualNetworks/<VNET_NAME>'
param publicIPAddresses_pip_mw_dev_scus_001_externalid string = '/subscriptions/<SUB_ID>/resourceGroups/<RESOURCE_NAME>/providers/Microsoft.Network/publicIPAddresses/<PUBLIC_IP_NAME>'




resource applicationGateways_agw_aks_test_scus_001_name_resource 'Microsoft.Network/applicationGateways@2020-11-01' = {
name: applicationGateways_agw_aks_test_scus_001_name
location: 'southcentralus'
properties: {
    sku: {
    name: 'Standard_v2'
    tier: 'Standard_v2'
    capacity: 2
    }
    httpListeners: [
    {
        name: 'appGatewayHttpListener'
        properties: {
        frontendIPConfiguration: {
            id: '${applicationGateways_agw_aks_test_scus_001_name_resource.id}/frontendIPConfigurations/appGatewayFrontendIP'
        }
        frontendPort: {
            id: '${applicationGateways_agw_aks_test_scus_001_name_resource.id}/frontendPorts/appGatewayFrontendPort'
        }
        protocol: 'Http'
        hostNames: []
        requireServerNameIndication: false
        }
    }
    ]
    requestRoutingRules: [
    {
        name: 'rule1'
        properties: {
        ruleType: 'Basic'
        httpListener: {
          id: resourceId('microsoft.network/applicationGateways/httpListeners', applicationGateways_agw_aks_test_scus_001_name, appGatewayHttpListenerName)
        }
        backendAddressPool: {
            id: '${applicationGateways_agw_aks_test_scus_001_name_resource.id}/backendAddressPools/appGatewayBackendPool'
        }
        backendHttpSettings: {
            id: '${applicationGateways_agw_aks_test_scus_001_name_resource.id}/backendHttpSettingsCollection/appGatewayBackendHttpSettings'
        }
        }
    }
    ]
}
}
