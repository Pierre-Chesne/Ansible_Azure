#!/bin/bash
echo 'alias python=python3' >> /home/pierrc/.bashrc
echo 'StrictHostKeyChecking no' >> /home/pierrc/.ssh/config
apt update && apt upgrade -y
apt install python3-pip -y
pip3 install ansible
su -l pierrc -c "git clone git@github.com:Pierre-Chesne/Ansible_Azure.git /home/pierrc/Ansible_Azure"