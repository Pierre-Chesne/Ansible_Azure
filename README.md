<p class="flotte">
 <img src="./png/aa.png" width='300'/>
</p>

## Ansible dans un environnement Azure<br/>
Avant de parler d'Ansible dans un environnement Azure, voici une petite introduction. Ansible est une plate-forme pour la configuration et la gestion de multiples environements d'architectures. Ansible combine le déploiement de logiciels "multi-noeud", l'exécution de tâches ad-hoc et la gestion de configuration. C'est un produit open-source qui appartient à Red Hat depuis octobre 2015. <br/>

L'achitecture Ansible s'appuie sur deux éléménts principaux:<br/>
- Le ___"control node"___ ou ___serveur Ansible___, il peut être exécuté à partir des environnements Python 2 (vers 2.7) ou Python 3 (vers 3.5 +). Le "control node" Ansible s'exécute uniquement depuis d'un environnement Linux (Red Hat, Debian, CentOS, macOS, BSD, WSL ...). Les configurations appelées "Playbooks"sont écrites en YAML. L'écriture des "Playbooks" s'appuie soit sur des modules natifs à Ansible ou sur des modules contenus dans des collections (ex: Galaxy Collection Azure "azure.azcollection"). Les "playbooks" sont ensuite envoyés en SSH/WinRM sur les machines cibles en s'appuyant sur un inventaire. <br/>

- Les ___"managed nodes"___ ou ___serveurs cibles___, ils peuvent être des environnements Linux ou Windows:<br/>
 -- Pour les environnements Linux, les "playbooks" s'exécuteront en Python et seront récupérés en SSH.<br/>
 -- Pour les environement Windows, les "playbooks" s'exécuteront en PowerShell et seront récupérés en WinRM ou SSH (SSH disponible dans Windows Server 2019).<br/>

A la différence d'autres solutions du marché (Puppet, Chef, ...), Ansible est "agentless" pas besoin d'installer d'agent sur les serveurs cibles.<br/>
<p class="flotte">
 <img src="./png/ansible-schema.png" width='300'/>
</p>
Il existe deux versions d’Ansible, <a href="www.ansible.com/community">la version communautaire</a> et la version entreprise proposée par Red Hat la <a href="www.redhat.com/fr/technologies/management/ansible">"Red Hat Ansible Automation Platform".</a>
Cette dernière s’appuie sur les composants:<br/>

- <a href="https://www.ansible.com/products/engine">"Ansible Engine".</a><br/>
- <a href="https://www.ansible.com/resources/webinars-training/collections-future-of-how-ansible-content-is-handled">"Ansible Content Collection".</a> <br/>
- <a href="https://www.ansible.com/products/tower">"Ansible Tower".</a><br/>
- <a href="https://www.redhat.com/cms/managed-files/ma-network-automation-for-everyone-e-book-f14954-201812-a4-fr.pdf">"Ansible Network Automation".</a><br/>
- <a href="https://www.ansible.com/products/automation-analytics">"Automation Analytics".</a><br/></br>

__Ansible__ présente de nombreuses qualités, la plus interressante est sa grande facilité d'accès:<br/>
- Le YAML, est lisible par l’homme et ne nécessite donc pas de connaissances ou de compétences particulières en codage.<br/>
- Pas besoin d'agent à installer sur les serveurs cibles, les configurations s'éxecutent en Python ou en PowerShell et on utilise OpenSSh et WinRM pour pousser les configurations.<br/>
- Facile à prendre en main, on écrit les configurations en "mode déclaratif" et les "Playbooks" sont idempotents.<br/>
- Un grand nombre de <a href="https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html"> modules </a> sont présents dans Ansible. On peut également trouver des modules supplémentaires proposés par la communauté Ansible sur <a href="https://galaxy.ansible.com/">"Ansible Galaxy".</a> (collections, roles ...) <br/>
- Ansible peut être également utilisé simplement dans des chaînes de déploiement (pipelines, workflows,...), il est présent par exemple dans les "runners de GitHub Actions" ou dans les "agents Azure Devops"<br/>

On execute les "Playbooks" soit en "command line" ou en "GUI" avec des solutions comme <a href="https://www.ansible.com/products/tower">"Ansible Tower"</a> (Red Hat) ou son pendant <a href="https://github.com/ansible/awx">"AWX".</a> (La version communautaire de Ansible Tower).<br/>
On retrouve toutes les informations pour l'écriture des "Playbooks" ici <a href="https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#playbook-syntax">  "Intro to playbooks"</a> et ici le <a href="https://docs.ansible.com/ansible/latest/user_guide/index.html">"User Guide".</a><br/>


## Ansible et Azure ##
Ansible est une excellente solution pour déployer et configurer des infrastructures dans Azure. Il est présent dans le "Cloud Shell" d'Azure et il existe également dans le "marketplace" d'Azure des VM prêtes à l'emploi (Ubuntu Ansibe,RHL Ansible Tower, Ansible AWX, ...).<br/> Voici plusieurs scénarios où Ansible pourra grandemant vous faciliter la tâche dans les déploimments et les configurations.<br/>

## Scénario 1: "Ansible pour déployer des ressources dans Azure (IaC)"<br/>
Ce scénario, un peu moins répandu du fait de la monté en puissance d'outils comme "Terraform", est pertinent ...<br/>
Pour configurer le "control node" ou serveur Ansible (serveur local ou VM Azure) il faudra installer:<br/>
- le gestionnaire de packets "python3-pip"<br/>
-  Ansible<br/>
-  les collections Azure (modules Azure). En effet depuis la version d'Ansible 2.10 les modules pour Azure sont séparés de la version Ansible de base.<br/>
-  Créer un "Service Principal" pour la connexion entre le serveur Ansible et l'abonnement Azure<br/>

Voici un exemple de procédure pour<a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Installation">  l'installation d'Ansible sur une distribution Linux Ubuntu 18.04 LTS avec un "Playbook" de création d'un "ressource groupe" </a>. <br/>
 Voici d'autres exemples de déploiment :<br/>
 -  <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Playbooks/IaC/VM"> Création d'une VM </a><br/>
 - <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Playbooks/IaC/VMSS"> Création d'un Scale Set de VM</a><br/>
 - <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Playbooks/IaC/Mysql">Création d'une Azure Database for MySQL</a><br/>
 - <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Playbooks/IaC/AppService">Création d'une App Service</a><br/>
 - <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Playbooks/IaC/AKS">Création d'un cluster AKS</a><br/>
 On peut également appeler les APIs REST d'Azure depuis un "playbook" avec le module ``azure.azcollection.azure_rm_resource`` <br/> 
 - <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Playbooks/IaC/API">Création de ressource Azure via les "Azure REST APIs"</a><br/> 

 ## Scénario 2: Ansible pour déployer et configurer vos applications dans Azure<br/>
Dans ce scénario on va utiliser Ansible depuis un poste "on-premise" ou depuis une VM dans Azure pour gérer l'installation et la configuration des applications (Base de données dans les VMs, Serveur Web dans les VM/VMSS, CMS...).<br/> 
Cela nécessite plusieurs prérequis:<br/>
-  Le serveur Ansible doit pouvoir pousser les configurations vers les serveurs cibles via des connexions en SSH. La configuration des clés SSH doit être faite( <a href="https://www.ssh.com/ssh/keygen/">"Voir cet Article"</a>). Enfin les VM dans Azure doivent pouvoir être accesssibles en SSH (NSG TCP 22) <br/>
-  Etablir un inventaire (liste des hosts cibles). L'inventaire est un élement essentiel pour appliquer les "Playbooks", car c'est à l'aide de cet inventaire que l'on renseigne les serveurs cibles.<a href="https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html">"Article pour construire un inventaire".</a><br/>

Il y a deux possibilés pour faire cet inventaire: Un inventaire __"Static"__ ou un inventaire __"Dynamic"__:<br/>
 - __Inventaire "Static"__<br/>
 Exemple d'un inventaire "Static" en YAML avec une variable d'inventaire (on utilisera python3 pour executer les "playbooks"). On renseigne manuellement les IPs ou les noms d'hôtes.
```
---
all:
  hosts:
    mail.example.com:
  children:
    webservers:
      hosts:
        20.71.44.177:
      vars:
        ansible_python_interpreter: /usr/bin/python3              
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
        three.example.com: 

```
Pour tester l'inventaire avec la commande : ``ansible-inventory`` (``ansible-inventory -i [inventaire] --graph``) :<br/>
```
ansible-inventory -i hosts.yml --graph
```
Résultat:
```
@all:
  |--@dbservers:
  |  |--one.example.com
  |  |--three.example.com
  |  |--two.example.com
  |--@ungrouped:
  |  |--mail.example.com
  |--@webservers:
  |  |--20.71.44.177
```
 Pour tester la connexion entre le serveur Ansible et les serveurs cibles, utiliser la commande "ad-hoc" qui appelle le module "ping" (``ansible -i [inventaire] -m ping`` ) :<br/>
```
ansible -i hosts.yml webservers -m ping
```
Résultat:
```
20.71.44.177 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```
- __Inventaire "Dynamic"__<br/>
Ansible peut être utilisé pour récupérer des informations auprès de diverses sources (y compris des sources d'Azure) pour construire un inventaire "Dynamic". Grâce au plugin "azure_rm", plus besoin de renseigner les IPs ou les noms d'hôtes dans l'inventaire on renseigne uniquement un "ressource group".<br/>
Le nom du fichier d'inventaire doit finir impérativement par __azure_rm__ (ex: mon_inventaire_azure_rm).<br/>
Pour construire cet inventaire "Dynamic", il est obligatoire qu'Ansible puisse interroger Azure, soit en passant par un "Service Principal" (<a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Installation">"procédure".</a>) ou soit avec une authentification Az Cli (<a href="https://docs.microsoft.com/fr-fr/cli/azure/install-azure-cli">"Az CLI".</a>)<br/>
Exemple:<br/>
```
---
plugin: azure_rm
include_vm_resource_groups:
- RG-Appli-01
auth_source: auto

keyed_groups:
- prefix: tag
  key: tags
```
Pour tester l'inventaire :<br/>
```
ansible-inventory -i monazure_rm.yml --graph
```
Résultat:<br/>
```
@all:
  |--@tag_Appli_01_Back:
  |  |--VM-Back_19d1
  |--@tag_Appli_01_Front:
  |  |--VM-Front_e9e9
  |--@ungrouped:
```
Dans cet inventaire, on récupère deux VM dans le "ressource groupe" "RG-Appli-01". L'une avec un Tag Azure "Appli_01 : Front" et l'autre avec un Tag "Appli_01:Back"<br/>
Pour tester les connexions entre le serveur Ansible et les deux VM dans Azure:<br/>
```
ansible -i monazure_rm.yml all -m ping
```
Résultat:<br/>
```
VM-Back_19d1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
VM-Front_e9e9 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
Pour tester la connexion entre le serveur Ansible et une VM du "ressource groupe", on s'appuie sur les tags Azure<br/>
```
ansible -i monazure_rm.yml -m ping tag_Appli_01_Back
```
Résultat:<br/>
```
VM-Back_19d1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
Maintenant que l'on a construit un inventaire static ou dynamique, reste plus à __exécuter les "Playbooks"__. Il y a deux approches pour le faire dans une infrastructure Azure:<br/>
__Première approche__, la plus simple, on pousse les configurations depuis un serveur en dehors d'Azure mais cela veut dire que pour pousser les configurations sur les serveurs cibles, ces derniers doivent avoir une IP publique et autoriser les flux entrants sur le port TCP 22. Cela reste discutable au point de vu sécurité.<br/>
__Deuxième approche__, on pousse les configurations depuis une VM dans Azure au plus près des serveurs cibles mais cela nécessite un peu plus de configuration et de préparation. Dans ce scénario on peut automatiser l'installation d'une VM Linux avec Ansible dans un subnet au sein d'un Vent des serveurs cibles par exemple.<br/> 

## Scénario 3: Ansible dans des chaînes de déploiement<br/>
<br/>  










