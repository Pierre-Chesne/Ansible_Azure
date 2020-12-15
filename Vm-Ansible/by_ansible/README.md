## Scénario: "Installation d'une VM Ansible dans Azure (au plus près des serveurs cibles)".<br/>
Voici un "Playbook Ansible" qui déploie automatiquement une VM dans Azure avec Ansible dans un subnet (au plus près des serveurs cibles)<br/>
Prérequis:<br/>
- Avoir un "Service Principal" ayant les droits de déployer des ressources dans un abonnement Azure
- Avoir Ansible d'installé sur votre machine ou serveur 
- Les serveurs cibles dans Azure doivent être accessible via SSH (TCP22)
- Les clés SSH (publique & privé) doivent être stocker sur la machine Ansible (ce sont les mêmes clés qui seront utilisées entre votre serveur Ansible qui déploie la VM Ansible dans Azure et ce sont  )
 


1/ Pour le déploiement de la VM (IaC)<br/>
```
ansible-playbook Install_Vm.yml
```


