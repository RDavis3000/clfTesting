param applicationGateways_ag_metabase_name string = 'ag_metabase'
param virtualNetworks_vn_cfr_azu_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_network/providers/Microsoft.Network/virtualNetworks/vn_cfr_azu'
param publicIPAddresses_ag_metabase_ip_pub_externalid string = '/subscriptions/c5c08118-927a-44f1-bb69-1b804148a0d2/resourceGroups/rg_MapCentia/providers/Microsoft.Network/publicIPAddresses/ag_metabase_ip_pub'

resource applicationGateways_ag_metabase_name_resource 'Microsoft.Network/applicationGateways@2022-01-01' = {
  name: applicationGateways_ag_metabase_name
  location: 'australiaeast'
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        id: '${applicationGateways_ag_metabase_name_resource.id}/gatewayIPConfigurations/appGatewayIpConfig'
        properties: {
          subnet: {
            id: '${virtualNetworks_vn_cfr_azu_externalid}/subnets/ag_subnet'
          }
        }
      }
    ]
    sslCertificates: [
      {
        name: 'wildcard.climatefriendly.com'
        id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
        properties: {
        }
      }
    ]
    trustedRootCertificates: []
    trustedClientCertificates: []
    sslProfiles: []
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ag_metabase_ip_pub_externalid
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_443'
        id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
        properties: {
          port: 443
        }
      }
      {
        name: 'port_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'ag_Backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/ag_Backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'crm_Backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/crm_Backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'crmdev_backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/crmdev_backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'qgis_backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/qgis_backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'devstage_backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/devstage_backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'fc_backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/fc_backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'stage_backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'globe_backend'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/globe_backend'
        properties: {
          backendAddresses: [
            {
              ipAddress: '10.0.4.4'
            }
          ]
        }
      }
    ]
    loadDistributionPolicies: []
    backendHttpSettingsCollection: [
      {
        name: 'metabase_http'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_http'
        properties: {
          port: 3000
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 60
        }
      }
      {
        name: 'crmdev_http_settings'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/crmdev_http_settings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 60
        }
      }
      {
        name: 'cc_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/cc_https'
        properties: {
          port: 9080
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          hostName: 'creditcounter.climatefriendly.com'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 60
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'hasura_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/hasura_https'
        properties: {
          port: 9090
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          hostName: 'gql.climatefriendly.com'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 60
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'qgis_http_settings'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/qgis_http_settings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 20
        }
      }
      {
        name: 'crm_http_settings'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/crm_http_settings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 180
        }
      }
      {
        name: 'creditcounter_dev_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/creditcounter_dev_https'
        properties: {
          port: 9080
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          hostName: 'creditcounter-dev.climatefriendly.com'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 60
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'hasura_dev_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/hasura_dev_https'
        properties: {
          port: 9090
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 60
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'metabase_dev_http'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_dev_http'
        properties: {
          port: 3001
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 20
        }
      }
      {
        name: 'creditcounter_stage_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/creditcounter_stage_https'
        properties: {
          port: 9080
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 20
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'hasura_stage_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/hasura_stage_https'
        properties: {
          port: 9090
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 20
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'metabase_stage_http'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_stage_http'
        properties: {
          port: 3001
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 20
        }
      }
      {
        name: 'retool_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/retool_https'
        properties: {
          port: 5000
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          hostName: 'retool.climatefriendly.com'
          pickHostNameFromBackendAddress: false
          requestTimeout: 600
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'retool_dev_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/retool_dev_https'
        properties: {
          port: 3000
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 600
        }
      }
      {
        name: 'retool_stage_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/retool_stage_https'
        properties: {
          port: 3000
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 600
        }
      }
      {
        name: 'fc_dev_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/fc_dev_https'
        properties: {
          port: 9081
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 600
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'fc_stage_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/fc_stage_https'
        properties: {
          port: 9081
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 600
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
          }
        }
      }
      {
        name: 'globe_http'
        id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/globe_http'
        properties: {
          port: 8080
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 90
          probe: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/probes/globe-probe'
          }
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: 'ac_crm_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ac_crm_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'crm.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_crmdev_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crmdev_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'crmdev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_crmdev_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crmdev_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'crmdev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_crm_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crm_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'crm.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_cc_80_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_80_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'creditcounter.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'metabase.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_hasura_listener_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_listener_https'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'gql.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_retool_listener_https'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_listener_https'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'retool.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_retool_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'retool.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_qgis_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_qgis_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'qgis.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_qgis_listener_443'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_qgis_listener_443'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'qgis.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_cc_dev_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_dev_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'creditcounter-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_cc_dev_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_dev_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'creditcounter-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_retool_dev_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_dev_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'retool-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_hasura_dev_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_dev_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'gql-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_hasura_dev_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_dev_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'gql-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_dev_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_dev_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'metabase-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_dev_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_dev_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'metabase-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_retool_dev_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_dev_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'retool-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_hasura_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'gql.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_cc_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'creditcounter.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_fcdev_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcdev_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'fc-dev.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_fcstage_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcstage_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'fc-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_retool_stage_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_stage_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'retool-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_stage_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_stage_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'metabase-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_hasura_stage'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_stage'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'gql-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_cc_stage_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_stage_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'creditcounter-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'ag_fcstage_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcstage_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'fc-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'af_retool_stage_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/af_retool_stage_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'retool-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_stage_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_stage_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'metabase-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_hasura_stage_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_stage_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'gql-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_cc_stage_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_stage_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'creditcounter-stage.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_globe_listener_80'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_globe_listener_80'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostName: 'globe.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'ag_globe_listener'
        id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_globe_listener'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/sslCertificates/wildcard.climatefriendly.com'
          }
          hostName: 'globe.climatefriendly.com'
          hostNames: []
          requireServerNameIndication: true
        }
      }
    ]
    listeners: []
    urlPathMaps: []
    requestRoutingRules: [
      {
        name: '${applicationGateways_ag_metabase_name}_routing_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/${applicationGateways_ag_metabase_name}_routing_rule'
        properties: {
          ruleType: 'Basic'
          priority: 10
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/ag_Backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_http'
          }
        }
      }
      {
        name: 'ag_crm_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_crm_rule'
        properties: {
          ruleType: 'Basic'
          priority: 20
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ac_crm_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/crm_Backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/crm_http_settings'
          }
        }
      }
      {
        name: 'ag_crmdev_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_crmdev_rule'
        properties: {
          ruleType: 'Basic'
          priority: 30
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crmdev_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/crmdev_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/crmdev_http_settings'
          }
        }
      }
      {
        name: 'ag_crmdev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_crmdev_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 40
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crmdev_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_crmdev_80_rule'
          }
        }
      }
      {
        name: 'ag_crm_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_crm_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 50
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crm_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_crm_80_rule'
          }
        }
      }
      {
        name: 'ag_cc_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_cc_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 60
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_80_listener'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_cc_80_rule'
          }
        }
      }
      {
        name: 'ac_cc_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ac_cc_rule'
        properties: {
          ruleType: 'Basic'
          priority: 70
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/ag_Backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/cc_https'
          }
        }
      }
      {
        name: 'ac_hasura_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ac_hasura_rule'
        properties: {
          ruleType: 'Basic'
          priority: 80
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_listener_https'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/ag_Backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/hasura_https'
          }
        }
      }
      {
        name: 'ag_hasura_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 90
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_hasura_80_rule'
          }
        }
      }
      {
        name: 'ag_retool_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_rule'
        properties: {
          ruleType: 'Basic'
          priority: 100
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_listener_https'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/ag_Backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/retool_https'
          }
        }
      }
      {
        name: 'ag_globe_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_globe_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 101
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_globe_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_globe_80_rule'
          }
        }
      }
      {
        name: 'ag_globe_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_globe_rule'
        properties: {
          ruleType: 'Basic'
          priority: 102
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_globe_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/globe_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/globe_http'
          }
          rewriteRuleSet: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/rewriteRuleSets/globe-rewrite'
          }
        }
      }
      {
        name: 'ag_retool_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 110
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_retool_80_rule'
          }
        }
      }
      {
        name: 'ag_qgis_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_qgis_rule'
        properties: {
          ruleType: 'Basic'
          priority: 120
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_qgis_listener_443'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/qgis_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/qgis_http_settings'
          }
        }
      }
      {
        name: 'ag_qgis_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_qgis_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 130
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_qgis_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_qgis_80_rule'
          }
        }
      }
      {
        name: 'ag_cc_dev_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_cc_dev_rule'
        properties: {
          ruleType: 'Basic'
          priority: 140
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_dev_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/devstage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/creditcounter_dev_https'
          }
        }
      }
      {
        name: 'ac_cc_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ac_cc_dev_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 150
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_dev_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ac_cc_dev_80_rule'
          }
        }
      }
      {
        name: 'ag_hasura_dev_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_dev_rule'
        properties: {
          ruleType: 'Basic'
          priority: 160
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_dev_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/devstage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/hasura_dev_https'
          }
        }
      }
      {
        name: 'ag_retool_dev_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_dev_rule'
        properties: {
          ruleType: 'Basic'
          priority: 170
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_dev_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/devstage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/retool_dev_https'
          }
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_dev_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/${applicationGateways_ag_metabase_name}_dev_rule'
        properties: {
          ruleType: 'Basic'
          priority: 180
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_dev_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/devstage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_dev_http'
          }
        }
      }
      {
        name: 'metabase_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/metabase_dev_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 190
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_dev_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/metabase_dev_80_rule'
          }
        }
      }
      {
        name: 'ag_hasura_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_dev_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 200
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_dev_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_hasura_dev_80_rule'
          }
        }
      }
      {
        name: 'ag_retool_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_dev_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 210
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_dev_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_retool_dev_80_rule'
          }
        }
      }
      {
        name: 'ag_fc_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_fc_rule'
        properties: {
          ruleType: 'Basic'
          priority: 220
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcdev_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/fc_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/fc_dev_https'
          }
        }
      }
      {
        name: 'ag_cc_stage_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_cc_stage_rule'
        properties: {
          ruleType: 'Basic'
          priority: 230
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_stage_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/creditcounter_stage_https'
          }
        }
      }
      {
        name: 'ag_cc_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_cc_stage_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 240
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_stage_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_cc_stage_80_rule'
          }
        }
      }
      {
        name: 'ag_hasura_stage_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_stage_rule'
        properties: {
          ruleType: 'Basic'
          priority: 250
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_stage'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/hasura_stage_https'
          }
        }
      }
      {
        name: 'ag_hasura_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_stage_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 260
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_stage_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_hasura_stage_80_rule'
          }
        }
      }
      {
        name: 'ag_retool_stage_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_stage_rule'
        properties: {
          ruleType: 'Basic'
          priority: 270
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_stage_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/retool_stage_https'
          }
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_stage_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/${applicationGateways_ag_metabase_name}_stage_rule'
        properties: {
          ruleType: 'Basic'
          priority: 280
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_stage_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_stage_http'
          }
        }
      }
      {
        name: '${applicationGateways_ag_metabase_name}_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/${applicationGateways_ag_metabase_name}_stage_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 290
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_stage_listener_80'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/metabase_stage_http'
          }
        }
      }
      {
        name: 'ag_fc_stage_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_fc_stage_rule'
        properties: {
          ruleType: 'Basic'
          priority: 300
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcstage_listener'
          }
          backendAddressPool: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendAddressPools/stage_backend'
          }
          backendHttpSettings: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/backendHttpSettingsCollection/fc_stage_https'
          }
        }
      }
      {
        name: 'ag_fc_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_fc_stage_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 310
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcstage_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_fc_stage_80_rule'
          }
        }
      }
      {
        name: 'ag_retool_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_stage_80_rule'
        properties: {
          ruleType: 'Basic'
          priority: 320
          httpListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/af_retool_stage_listener_80'
          }
          redirectConfiguration: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_retool_stage_80_rule'
          }
        }
      }
    ]
    routingRules: []
    probes: [
      {
        name: 'cc_httpsae1f7144-13d3-4060-93ee-b2aa4c68e09b'
        id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_httpsae1f7144-13d3-4060-93ee-b2aa4c68e09b'
        properties: {
          protocol: 'Http'
          path: '/'
          interval: 30
          timeout: 30
          unhealthyThreshold: 3
          pickHostNameFromBackendHttpSettings: true
          minServers: 0
          match: {
            statusCodes: [
              '200-401'
            ]
          }
        }
      }
      {
        name: 'cc_401_probe'
        id: '${applicationGateways_ag_metabase_name_resource.id}/probes/cc_401_probe'
        properties: {
          protocol: 'Http'
          host: 'creditcounter.climatefriendly.com'
          path: '/'
          interval: 30
          timeout: 30
          unhealthyThreshold: 3
          pickHostNameFromBackendHttpSettings: false
          minServers: 0
          match: {
            statusCodes: [
              '200-401'
            ]
          }
        }
      }
      {
        name: 'globe-probe'
        id: '${applicationGateways_ag_metabase_name_resource.id}/probes/globe-probe'
        properties: {
          protocol: 'Http'
          host: '10.0.4.4'
          path: '/geoserver'
          interval: 30
          timeout: 30
          unhealthyThreshold: 3
          pickHostNameFromBackendHttpSettings: false
          minServers: 0
          match: {
          }
        }
      }
    ]
    rewriteRuleSets: [
      {
        name: 'globe-rewrite'
        id: '${applicationGateways_ag_metabase_name_resource.id}/rewriteRuleSets/globe-rewrite'
        properties: {
          rewriteRules: []
        }
      }
    ]
    redirectConfigurations: [
      {
        name: 'ag_crmdev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_crmdev_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_crmdev_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_crmdev_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_crm_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_crm_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ac_crm_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_crm_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_cc_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_cc_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_cc_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_hasura_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_hasura_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_listener_https'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_retool_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_retool_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_listener_https'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_qgis_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_qgis_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_qgis_listener_443'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_qgis_80_rule'
            }
          ]
        }
      }
      {
        name: 'ac_cc_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ac_cc_dev_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_dev_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ac_cc_dev_80_rule'
            }
          ]
        }
      }
      {
        name: 'metabase_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/metabase_dev_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/${applicationGateways_ag_metabase_name}_dev_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/metabase_dev_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_hasura_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_hasura_dev_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_dev_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_dev_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_retool_dev_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_retool_dev_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_dev_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_dev_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_cc_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_cc_stage_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_cc_stage_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_cc_stage_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_hasura_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_hasura_stage_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_hasura_stage'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_hasura_stage_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_fc_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_fc_stage_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_fcstage_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_fc_stage_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_retool_stage_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_retool_stage_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_retool_stage_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_retool_stage_80_rule'
            }
          ]
        }
      }
      {
        name: 'ag_globe_80_rule'
        id: '${applicationGateways_ag_metabase_name_resource.id}/redirectConfigurations/ag_globe_80_rule'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: '${applicationGateways_ag_metabase_name_resource.id}/httpListeners/ag_globe_listener'
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: '${applicationGateways_ag_metabase_name_resource.id}/requestRoutingRules/ag_globe_80_rule'
            }
          ]
        }
      }
    ]
    privateLinkConfigurations: []
    webApplicationFirewallConfiguration: {
      enabled: false
      firewallMode: 'Detection'
      ruleSetType: 'OWASP'
      ruleSetVersion: '3.1'
      disabledRuleGroups: []
      exclusions: []
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
    }
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 2
    }
  }
}
