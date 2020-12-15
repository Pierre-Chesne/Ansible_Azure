## Scénario: "Installation d'une VM Ansible dans Azure (au plus près des serveurs cibles)".<br/>
<p class="flotte">
 <img src="./png/ansible-ansible.png" width='300'/>
</p>
Voici un "Playbook Ansible" qui déploie automatiquement une VM dans Azure avec Ansible dans un subnet (au plus près des serveurs cibles)<br/>
Prérequis:<br/>
- Avoir un "Service Principal" ayant les droits de déployer des ressources dans un abonnement Azure
- Avoir Ansible d'installé sur votre machine ou serveur (on-premise)
- Les serveurs cibles dans Azure doivent être accessible via SSH (TCP22)
- Les clés SSH (publique & privé) doivent être stocker sur la machine Ansible (ce sont les mêmes clés qui seront utilisées entre votre serveur Ansible qui déploie la VM Ansible dans Azure et ce sont les mêmes clés qui seront utilisées pour les configurations entre le serveur Ansible Azure et les serveurs cibles)
 


1/ Pour le déploiement de la VM (IaC)<br/>
```
ansible-playbook Install_Vm.yml
```


