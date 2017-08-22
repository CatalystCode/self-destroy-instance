#!/bin/bash

# Configs

# For authentication
tenant_id=$TENANT_ID
client_id=$CLIENT_ID
client_secret=$CLIENT_SECRET
resource=https://management.azure.com/

# For API calls
subscription_id=$SUBSCRIPTION_ID
resource_group=$RESOURCE_GROUP
api_version=2016-03-30


get_access_token() {
  data=$(curl -X POST \
          -H "Cookie: flight-uxoptin=true; stsservicecookie=ests; x-ms-gateway-slice=productionb; stsservicecookie=ests" \
          -H "Content-Type: application/x-www-form-urlencoded" \
          --data-urlencode "grant_type=client_credentials" \
          --data-urlencode "client_id=$client_id" \
          --data-urlencode "client_secret=$client_secret" \
          --data-urlencode "resource=$resource" \
          https://login.microsoftonline.com/$tenant_id/oauth2/token)

  access_token=$(echo $data | jq -r .access_token)

  echo $access_token
}

get_metadata() {
  curl -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-04-02"
}

suicide() {
  metadata=$(get_metadata)
  name=$(echo $metadata | jq -r .compute.name)
  access_token=$(get_access_token)
  scale_set=${name%_*}
  instance_num=${name#*_}

  curl -X DELETE \
    --header "Authorization: Bearer $access_token" \
    https://management.azure.com/subscriptions/$subscription_id/resourceGroups/$resource_group/providers/Microsoft.Compute/virtualMachineScaleSets/$scale_set/virtualMachines/$instance_num?api-version=$api_version
}

suicide
echo "Goodbye cruel world..."
