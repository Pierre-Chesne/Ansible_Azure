## Scénario: "Installation d'une VM Ansible dans Azure (au plus près des serveurs cibles)".<br/>
Voici un "Playbook Ansible" qui déploie automatiquement une VM dans Azure avec Ansible dans un subnet (au plus près des serveurs cibles)<br/>
Prérequis:<br/>
- Avoir un "Service Principal" ayant les droits de déployer des ressources dans un abonnement Azure


1/ Pour le déploiement de la VM (IaC)<br/>
```
ansible-playbook Install_Vm.yml
```


