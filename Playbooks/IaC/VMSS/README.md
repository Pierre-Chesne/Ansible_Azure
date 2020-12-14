```ansible-playbook main.yml```<br/>
Pour exécuter le playbook : ```ansible-playbook main.yml```<br/>
Le playbook déploie:<br/>
- Un "resource group"
- Une "Public IP"
- Un "Virtual Network"
- Un "Subnet"
- Un "Network Security Group" avec les règles (Http;SSH)
- Une "NIC"
- Un VM Sclale Set

Pour les paramétrages du déploiement voir le fichier ```vars.yml```