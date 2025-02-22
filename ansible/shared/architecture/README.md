
Run playbook
ansible-playbook --inventory inventory/cluster/hosts playbook.yaml

Tester la connexion
ansible all -i inventory -m ping

