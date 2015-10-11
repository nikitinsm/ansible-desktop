#!/usr/bin/env bash

set -e

current_user=$USER

# Install sudo
if ! test -x /usr/bin/sudo; then 
    su -c "apt-get install -y sudo && echo '$current_user ALL=(ALL) ALL' > /etc/sudoers.d/$current_user"
fi

# Install git and Ansible
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y git python-pip python-dev openssh-server libyaml-cpp-dev
sudo pip install -U pip ansible

# Configure ansible inventory
sudo chmod 777 /etc/ansible
sudo echo "localhost ansible_connection=local" > /etc/ansible/hosts

# Prepare repository
sudo mkdir -p /opt/nikitinsm/ && cd /opt/nikitinsm/
sudo chown -R $current_user:current_user ./
git clone https://github.com/nikitinsm/ansible-desktop.git && cd ansible-desktop

# Setup via Ansible
sudo ansible-playbook setup.yml
