Pour exécuter le playbook : ```ansible-playbook main.yml```<br/>
Le playbook déploie:<br/>
- Un "resource group"
- Un compte de stockage en utilisant le module "azure.azcollection.azure_rm_resource" qui fait appel aux APIs d'Azure