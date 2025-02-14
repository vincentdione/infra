#!/bin/bash

# Désactiver le swap (Kubernetes ne le supporte pas)
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

# Activer les modules nécessaires pour Kubernetes
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# Configurer les paramètres réseau pour Kubernetes
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

# Installer les dépendances
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl

# Ajouter la clé et le repo Kubernetes
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg

# Ajouter le dépôt Kubernetes avec la nouvelle clé
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Mettre à jour les dépôts
sudo apt-get update -y
# Installer kubeadm, kubelet et kubectl
apt-get update -y
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Installer Docker
apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Configurer Docker pour Kubernetes (utilisation de systemd comme cgroup driver)
cat <<EOF | tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl daemon-reload
systemctl restart docker

