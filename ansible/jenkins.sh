#!/bin/bash

# Mettre à jour les paquets
sudo apt update && sudo apt upgrade -y

# Installer Java (Jenkins nécessite Java)
sudo apt install -y openjdk-11-jdk

# Ajouter la clé et le dépôt Jenkins
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

# Installer Jenkins
sudo apt update
sudo apt install -y jenkins

# Démarrer et activer Jenkins
sudo systemctl enable --now jenkins

echo "Jenkins est installé et accessible sur http://192.168.56.13:8080"
