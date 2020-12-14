Pour exécuter le playbook : ```ansible-playbook main.yml```<br/>
Le playbook déploie:<br/>
- Un "resource group"
- Du service "Azure Database for MySQL server" et la Base de donnée<br/>

Pour ouvrir le "firewall" pour accéder au serveur "MySQL" depuis l'extérieur voici l'exemple de playbook<br/>
```
# Firewall
---
- name: Creation d'une Azure Database for MySQL
  hosts: localhost
  vars_files:
    - vars.yml

  tasks:
    - azure.azcollection.azure_rm_resource:
        api_version: '2017-12-01'
        resource_group: "{{ rg_name }}"
        provider: dbformysql
        resource_type: servers
        resource_name: "{{ mysqlserver_name }}"
        subresource:
          - type: firewallrules
            name: externalaccess
        body:
          properties:
            startIpAddress: "0.0.0.0"
            endIpAddress: "255.255.255.255"
```