#!/bin/bash
# recuperation des ip privé du scale set
ip0=$(az vmss nic list -g RG_VMSS_Hosts --vmss-name hosts --query "[0].ipConfigurations[0].privateIpAddress" -o tsv)
ip1=$(az vmss nic list -g RG_VMSS_Hosts --vmss-name hosts --query "[1].ipConfigurations[0].privateIpAddress" -o tsv)
ip2=$(az vmss nic list -g RG_VMSS_Hosts --vmss-name hosts --query "[2].ipConfigurations[0].privateIpAddress" -o tsv)

cat > hosts.yml <<EOF
webservers:
  hosts:
    $ip0:
    $ip1:
    $ip2:

  vars:
    ansible_python_interpreter: /usr/bin/python3
EOF