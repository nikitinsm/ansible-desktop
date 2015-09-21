#!/usr/bin/env bash

set -e

current_user=$USER

# Install sudo
if ! test -x /usr/bin/sudo; then 
    su -c "apt-get install -y sudo && echo '$current_user ALL=(ALL) ALL' > /etc/sudoers.d/$current_user"
fi

# Install git and Ansible
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y git python-pip python-dev openssh-server
sudo pip install -U pip ansible

# Configure ansible inventory
sudo chmod 777 /etc/ansible
sudo echo "localhost ansible_connection=local" > /etc/ansible/hosts
# sudo chmod -R 777 /etc/ansible

# Setup via Ansible
sudo ansible-playbook setup.yml