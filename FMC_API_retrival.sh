#!/bin/bash

# To find ACP uuid from ftd clish expert mode
#  
# look for like that says policy at the top of the output
# head -n 15 /ngfw/var/sf/detection_engines/d3d828fa-896c-11ed-a4a5-2c2dbfe9b5dc/ngfw.rules  
#### ngfw.rules


# Prompt the username

 read -rp "Enter the APIUserName: " user

#
#  

#username


  read -rp "Enter the pass: " pass

#fmc hostname
#  
  read -rp "Enter the FMCHostName: " fmc


# examples UUID from ftds

ACPs=(
  "2CF89BC0-4DF6-0ed3-0002-000000000001"
  "2CF89BC0-4DF6-0ed3-0000-000000000001"
  "2CF89BC0-4DF6-0ed3-0002-000000000001"
  "2CF89BC0-4DF6-0ed3-0002-000000000008"
  "2CF89BC0-4DF6-0ed3-0002-000000000001"
#  "2CF89BC0-4DF6-0ed3-0002-000000000003"
   "2cf89bc0-4df6-0ed3-0000-000000000007"
)

for item in "${ACPs[@]}"; do

    echo "Processing: $item"

curl -v -sk -X GET \
  "https://$fmc/api/fmc_config/v1/domain/e276abec-e0f2-11e3-8169-6d9ed49b625f/policy/accesspolicies/$item/accessrules?limit=100000000&expanded=true" -H "X-auth-access-token: $(curl -sk -v -X POST https://$fmc/api/fmc_platform/v1/auth/generatetoken -u "$user:$pass" -H "Content-Type: application/json" -D - | grep -Fi X-auth-access-token | awk '{print $2}' | tr -d '\r')" -H "Content-Type: application/json"

   echo "Done "

done
