#!/bin/bash
RgNameHosts="RG_VMSS_Hosts" # "Resource Group" des Hosts cibles
RgNameAnsible="RG_Config_Ansible" # "Resource Group" de la VM Ansible
Location="westeurope" # Location
VnetHosts="Vnet_VM_Hosts" # Vnet des Hosts cibles
SubnetHosts="Subnet_VM_Hosts" # Subnet des Hosts cibles
IpPub="Ansible-Mgt" # IP de mgt de la VM Ansible
Nsg="Ansible-Nsg" # NSG de la VM Ansible
Nic="Ansible-Nic" # Nic de la VM Ansible
Vm="Ansible-Vm" # Nom de la VM Ansible
Image="UbuntuLTS" # Ubuntu 18.04TLS
VmSize="Standard_A2_v2" # Taille de la VM
User="pierrc" # Compte Utilisateur

# Creation du "resource group" pour la VM Ansible
az group create \
  --location $Location \
  --name $RgNameAnsible

# Creation IP publique (rebond Ansible)
az network public-ip create \
  --resource-group $RgNameAnsible \
  --name $IpPub

# Creation NSG VM Ansible 
az network nsg create \
  --resource-group $RgNameAnsible \
  --name $Nsg

# Creation regle SSH
az network nsg rule create \
  --resource-group $RgNameAnsible \
  --nsg-name $Nsg \
  --name Allow-SSH-All \
  --access Allow \
  --protocol Tcp \
  --direction Inbound \
  --priority 1000 \
  --source-address-prefix Internet \
  --source-port-range "*" \
  --destination-address-prefix "*" \
  --destination-port-range 22

# Creation de la NIC Ansible dans le subnet des Hosts
az network nic create \
  --resource-group $RgNameAnsible \
  --name $Nic \
  --subnet "/subscriptions/95014b70-0907-44b9-a33f-229e4842ae85/resourceGroups/$RgNameHosts/providers/Microsoft.Network/virtualNetworks/$VnetHosts/subnets/$SubnetHosts" \
  --network-security-group $Nsg \
  --public-ip-address $IpPub

# Creation de la VM Ansible
az vm create \
  --resource-group $RgNameAnsible \
  --name $Vm \
  --nics $Nic \
  --image $Image \
  --size $VmSize \
  --admin-username $User \
  --generate-ssh-keys

# Copie de la cle SSH privee pour la communication SSH Ansible -> hosts
ip=$(az vm show -d -g $RgNameAnsible -n $Vm --query "publicIps" -o tsv)
scp  /home/$User/.ssh/id_rsa $ip:/home/$User/.ssh/

# Custom Script pour l'installation d'Ansible
az vm extension set \
  --resource-group $RgNameAnsible \
  --vm-name $Vm \
  --name CustomScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/Pierre-Chesne/Ansible_Azure/main/bash/Install_Ansible.sh"],"commandToExecute": "sh Install_Ansible.sh"}'
