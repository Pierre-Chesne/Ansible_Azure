## Exemple de déploiement d'une configuration Wordpress dans un conteneur "Docker" sur une VM Ubuntu dans Azure
Prérequis :<br/>
- Une VM Ubuntu 18.04LTS déployée dans Azure
- NSG avec un accès TCP 22 (ssh)
- Renseigner le nom du "resource group" dans l'inventaire "dynamic" (mon_inventaire_azure_rm.yml)

Voici les "tasks" du "playbook":<br/>
- Mise à jour de la VM Ubuntu -> Module Ansible "apt"
- Installation des dépendances pour l'installation de "Docker" -> Module Ansible "apt"
- Ajout du "répository" -> Module Ansible "apt_repository"
- Installation de Docker -> Module Ansible "apt"
- Installation de "docker-compose" -> Module Ansible "apt"
- Creation du repertoire "wordpress" -> Module Ansible "file"
- Copie du fichier docker-compose.yml -> Module Ansible "copy"
- Exécution du "docker compose" -> Module Ansible "shell"

Exécution du playbook :<br/>
```
ansible-playbook -i mon_inventaire_azure_rm.yml main.yml
```
S'il y a plusieurs VM dans le "resource group", il y a possibilité d'appliquer le "playbook" à qu'une VM de l'inventaire en passant par les "tags" Azure.<br/>
Exemple pour récupérer les tags Azure des VM de l'inventaire "dynamic" :
```
ansible-inventory -i mon_inventaire_azure_rm.yml --graph
```
Exemple de résultat :<br/>
```
@all:
  |--@tag_appli_01_wp:
  |  |--Vm-Host_9daf
  |--@tag_appli_02_DB:
  |  |--VM-DB-00_6422
  |--@ungrouped:
```
Exemple pour exécuter le "playbook" à une VM d'un "resource group" en passant par les "tags" Azure
```
ansible-playbook -i mon_inventaire_azure_rm.yml main.yml --limit=tag_appli_01_wp
```