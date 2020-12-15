<p class="flotte">
 <img src="https://github.com/Pierre-Chesne/Ansible_Azure/blob/main/png/ansible-ansible.png" width='500'/>
</p>

## Scénario: "Installation d'une VM Ansible dans Azure (au plus près des serveurs cibles)".<br/>
Voici un "Playbook Ansible" qui déploie automatiquement une VM dans Azure avec Ansible dans un subnet (au plus près des serveurs cibles)<br/>
Prérequis:<br/>

- Avoir un "Service Principal" ayant les droits de déployer des ressources dans un abonnement Azure <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Installation">- Procédure</a>
- Avoir Ansible avec les modules Azure d'installé sur votre machine ou serveur (on-premise) <a href="https://github.com/Pierre-Chesne/Ansible_Azure/tree/main/Installation">- Procédure</a>
- Les serveurs cibles dans Azure doivent être accessible via SSH (TCP22)
- Les clés SSH (publique & privé) doivent être stocker sur le serveur Ansible "on-premise" (ce sont les mêmes clés qui seront utilisées entre votre serveur Ansible qui déploie la VM Ansible dans Azure et ce sont les mêmes clés qui seront utilisées pour les configurations entre le serveur Ansible Azure et les serveurs cibles)

1/ Pour le déploiement de la VM (IaC)<br/>
```
ansible-playbook Install_Vm.yml
```
Ce "playbook" déploie :
- Un "resource group - RG_Playbook"
- Une "Public IP - IP-Pub-Playbook "
- Un "Network Security Group avec une règle (SSH) -NSG_Playbook"
- Une "NIC - Nic_Playbook"
- Une VM - Vm-Playbook<br/>

Il faudra simplement renseigner dans le fichier ```vars.yml```:<br/>
- le "resource group" du Vnet/Subnet des serveurs cibles
- le "vnet" des serveurs cibles
- le "subnet" des serveurs cibles<br/>

2/ Pour déployer Ansible sur la VM dans Azure <br/>
Editer le fichier ```credentials``` et renseigner:<br/>
```
[default]
subscription_id=<your-subscription_id>
client_id=<security-principal-appid>
secret=<security-principal-password>
tenant=<security-principal-tenant>
```
Puis exécuter le playbook :<br/>
```
ansible-playbook -i inventaire_azure_rm.yml Install_Ansible.yml
```

3/ Pour déployer les configurations sur les serveurs cibles, reste plus qu'a se connecter sur la VM Ansible dans Azure , faire un inventaire "dynamic" et exécuter les playbooks. Une fois terminer, détrire le "resource groupe RG_Playbook" 

