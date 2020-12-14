Pour exécuter le playbook : ```ansible-playbook main.yml```<br/>
Le playbook déploie:<br/>
- Un "resource group"
- Une "Public IP"
- Un "Load Balancer" (probe TCP80 ; Front TCP80 ; Back TCP80)
- Un "Virtual Network"
- Un "Subnet"
- Un "Network Security Group" avec les règles (Http,SSH)
- Une "NIC"
- Un VM Sclale Set

Pour les paramétrages du déploiement voir le fichier ```vars.yml```