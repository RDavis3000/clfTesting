param location string = resourceGroup().location
param rg string = resourceGroup().name
param virtual_network_name string = 'my_virtual_network'
param gwSubnetName string = 'myGatewaySubnet'
param public_ip_gateway string = 'my_public_ip'
param p2s_vpn_name string = 'myPoint_toSite'
param p2s_subnet_name string = 'p2s_subnet'

resource public_ip_gateway_resource 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
  name: public_ip_gateway
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '40.161.130.50'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtual_network_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
  name: '${virtual_network_name}/GatewaySubnet'
  properties: {
    addressPrefix: '10.2.255.0/25'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtual_network_name_resource
  ]
}

resource virtual_network_name_p2s_subnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
  name: '${virtual_network_name}/p2s_subnet'
  properties: {
    addressPrefix: '10.2.1.0/24'
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtual_network_name_resource
  ]
}

resource p2s_vpn_name_resource 'Microsoft.Network/virtualNetworkGateways@2022-01-01' = {
  name: p2s_vpn_name
  location: location
  properties: {
    enablePrivateIpAddress: false
    ipConfigurations: [
      {
        name: 'default'
        id: '${p2s_vpn_name_resource.id}/ipConfigurations/default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: public_ip_gateway_resource.id
          }
          subnet: {
            id: virtual_network_name_GatewaySubnet.id
          }
        }
      }
    ]
    natRules: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    activeActive: false
    vpnClientConfiguration: {
      vpnClientAddressPool: {
        addressPrefixes: [
          '119.x.x.0/24'
        ]
      }
      vpnClientProtocols: [
        'OpenVPN'
      ]
      vpnAuthenticationTypes: [
        'Certificate'
      ]
      vpnClientRootCertificates: [
        {
          name: 'Rahman'
          id: '${p2s_vpn_name_resource.id}/vpnClientRootCertificates/MyCert'
          properties: {
            publicCertData: 'xxxxxxxxxxx=='
          }
        }
      ]
      vpnClientRevokedCertificates: []
      radiusServers: []
      vpnClientIpsecPolicies: []
    }
    bgpSettings: {
      asn: 65515
      bgpPeeringAddress: '10.2.255.126'
      peerWeight: 0
      bgpPeeringAddresses: [
        {
          ipconfigurationId: '${p2s_vpn_name_resource.id}/ipConfigurations/default'
          customBgpIpAddresses: []
        }
      ]
    }
    customRoutes: {
      addressPrefixes: []
    }
    vpnGatewayGeneration: 'Generation1'
  }
}

resource virtual_network_name_resource 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: virtual_network_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        id: resourceId(rg, 'Microsoft.Network/virtualNetworks/subnets', virtual_network_name ,gwSubnetName)
        properties: {
          addressPrefix: '10.2.255.0/25'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'p2s_subnet'
        // id: virtual_network_name_p2s_subnet.id
        id: resourceId(rg, 'Microsoft.Network/virtualNetworks/subnets', virtual_network_name ,p2s_subnet_name)
        properties: {
          addressPrefix: '10.1.1.0/24'
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}
