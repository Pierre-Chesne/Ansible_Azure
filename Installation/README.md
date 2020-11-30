# Ansible_Azure 
1. **Installation Ansible**<br/>
Exemple : Ubuntu 18.04 LTS :<br/>
- Dans le `.bashrc` : Créez un alias -> `alias python='python3'`<br/>
- Exécutez les commands :<br/>
```
~$ sudo apt update 
~$ sudo apt upgrade 
~$ sudo apt install python3-pip
~$ pip3 install ansible
~$ wget https://raw.githubusercontent.com/ansible-collections/azure/dev/requirements-azure.txt
~$ pip3 install -r requirements-azure.txt
~$ ansible-galaxy collection install azure.azcollection
```
- Test :<br/>
`~$ ansible --version`<br>
retour :<br/>
```
ansible 2.10.3
  config file = None
  configured module search path = ['/home/pierrc/.ansible/plugins/modules', '/usr/share/ansible/&plugins/modules']
  ansible python module location = /home/pierrc/.local/lib/python3.6/site-packages/ansible
  executable location = /home/pierrc/.local/bin/ansible
  python version = 3.6.9 (default, Oct  8 2020, 12:12:24) [GCC 8.4.0]
```
2. **Connexion avec Azure**<br/>
- Création d'un "Service Principal":<br/>
`az ad sp create-for-rbac --name ansible007`<br/>
Récuprez :<br/>
&nbsp;&nbsp;id de l'application<br/>
&nbsp;&nbsp;son secret<br/>
&nbsp;&nbsp;id de votre abonnement<br/>
&nbsp;&nbsp;id de votre tenant<br/>
- Créez un fichier `~/.azure/credentials`:<br/>
```
$~ mkdir ~/.azure
$~ nano ~/.azure/credentials
```
Copier le code en mettant vos informations (id de votre abonnement; id de l'application; son secret et id de votre tenant )
```
[default]
subscription_id=<your-subscription_id>
client_id=<security-principal-appid>
secret=<security-principal-password>
tenant=<security-principal-tenant>
```
- **Test de la configuration**<br/>
Création d'un playbook :<br/>
`nano rg.yml`
Copiez le code<br/>
```
---
- name: Using Azure collection
  hosts: localhost
  tasks:
    - azure.azcollection.azure_rm_resourcegroup:
        name: ansible-test
        location: westeurope
      register: rg

    - debug:
        var: rg
```
Pour exécuter le "playbook"<br/>
```
$~ ansible-playbook rg.yml
```