#!/bin/bash


# Installer les dépendances
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl
apt install -y ansible python3-pip 

