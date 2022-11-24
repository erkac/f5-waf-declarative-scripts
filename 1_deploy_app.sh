#!/bin/bash

#--header 'Authorization: Basic YWRtaW46YWRtaW4=' \
#--header 'Cookie: BIGIPAuthCookie=E9lau5QPPQehC77GTUJ8vsdiC7qdMbD6VK8FITFC; BIGIPAuthUsernameCookie=admin' \

curl -u "admin:UfoPorno5!" -k --location --request POST 'https://10.1.1.245/mgmt/shared/appsvcs/declare' \
--header 'Content-Type: application/json' \
--data-raw '{
    "class": "AS3",
    "action": "deploy",
    "persist": true,
    "declaration": {
        "class": "ADC",
        "schemaVersion": "3.2.0",
        "id": "Prod_API_AS3",
        "petstore-prod": {
            "class": "Tenant",
            "defaultRouteDomain": 0,
            "API": {
                "class": "Application",
                "template": "generic",
                "VS_API_petstore": {
                    "class": "Service_HTTPS",
                    "remark": "Accepts HTTPS/TLS connections on port 443",
                    "virtualAddresses": ["10.1.10.200"],
                    "redirect80": true,
                    "pool": "pool_petstore",
                    "profileTCP": {
                        "egress": "wan",
                        "ingress": { "use": "TCP_Profile" } },
                    "profileHTTP": { "use": "custom_http_profile" },
                    "serverTLS": { "bigip": "/Common/clientssl" }
                },
                "pool_petstore": {
                    "class": "Pool",
                    "monitors": ["http"],
                    "members": [{
                        "servicePort": 88,
                        "serverAddresses": ["10.1.10.1"]
                    }]
                },
                "custom_http_profile": {
                    "class": "HTTP_Profile",
                    "xForwardedFor": true
                },
                "TCP_Profile": {
                    "class": "TCP_Profile",
                    "idleTimeout": 60 }
            }
        }
    }
}
'

