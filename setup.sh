#!/usr/bin/env bash

set -e

current_user=$USER

# Install git and Ansible
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y git python-pip python-dev openssh-server libyaml-cpp-dev
sudo pip install -U pip ansible

# Configure ansible inventory
if ! test -d /etc/ansible; then 
    sudo mkdir /etc/ansible
fi
sudo chmod 777 /etc/ansible
sudo echo "localhost ansible_connection=local" > /etc/ansible/hosts

# Prepare repository
if ! test -d /opt/nikitinsm; then 
    sudo mkdir -p /opt/nikitinsm
fi
cd /opt/nikitinsm/
sudo chown -R $current_user:$current_user ./

if ! test -d /opt/nikitinsm/ansible-desktop; then 
    git clone https://github.com/nikitinsm/ansible-desktop.git
    cd ./ansible-desktop
else
    cd /opt/nikitinsm/ansible-desktop
    git pull
fi

# Setup via Ansible
ansible-playbook setup.yml
