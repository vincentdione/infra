#!/bin/bash


# Installer les dépendances
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install -y ansible python3-pip 
ansible-galaxy collection install  kubernetes.core
