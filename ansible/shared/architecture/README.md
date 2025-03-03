Lancer d'abord cette commande pour pouvoir lancer rancher
installer la collection kubernetes.core
ansible-galaxy collection install -r requirements.yml

Run playbook
ansible-playbook --inventory inventory/cluster/hosts playbook.yaml

Tester la connexion
ansible all -i inventory -m ping

