## Exemple de déploiement d'une configuration Wordpress dans un conteneur "Docker" sur VM Ubuntu dans Azure
Prérequis :<br/>
- Une VM Ubuntu 18.04LTS déployée dans Azure
- NSG avec un accès TCP 22 (ssh)
- Renseigner le nom du ressource dans l'inventaire "dynamic" (mon_inventaire_azure_rm.yml)  

Exécution du playbook :<br/>
```
ansible-playbook -i mon_inventaire_azure_rm.yml main.yml
```