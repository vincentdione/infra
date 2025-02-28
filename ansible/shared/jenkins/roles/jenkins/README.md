1. Ansible vault Commands
a. Create new vault
ansible-vault create group_vars/my_vault.yml
Set the password for the vault

my_message: "This is test message from vault"
You can't view the file if you run the following command

cat groups_vars/my_vault.yml 
b. Edit the encrypted file
ansible-vault edit group_vars/my_vault.yml
Enter the password for the vault

c. View the encrypted file
ansible-vault view group_vars/my_vault.yml 
d. Encrypt existing file
ansible-vault encrypt group_vars/plain_text_secret_file.txt 
Set the password for the vault


2. Run the playbook with vault using --ask-vault-pass
a. Run the playbook
# Vault file - my_vault.yml
ansible-playbook --inventory inventory/ansible-vault/hosts ansible-vault-playbook.yml -e @group_vars/my_vault.yml --ask-vault-pass
-e @group_vars/my_vault.yml - associate extra variables to the playbook


3. Encrypting the vault with base64 generated password
a. Generate the base64 password file pass_file/ansible-vault.pass
openssl rand -base64 2048 > pass_file/ansible-vault.pass
b. Create vault with pass_file/ansible-vault.pass
ansible-vault create group_vars/my_vault_with_bas64_pass.yml --vault-password-file=pass_file/ansible-vault.pass
c. View the content of the vault with pass file
ansible-vault view group_vars/my_vault_with_bas64_pass.yml --vault-password-file=pass_file/ansible-vault.pass
# Vault file - my_vault_with_bas64_pass.yml
ansible-playbook --inventory inventory/ansible-vault/hosts ansible-vault-playbook.yml -e @group_vars/my_vault_with_bas64_pass.yml --vault-password-file=pass_file/ansible-vault.pass

3. Reading the ansible password from the environment variable - ANSIBLE_VAULT_PASSWORD_FILE
a. Set the following the Environment Variable -

export ANSIBLE_VAULT_PASSWORD_FILE=/Users/rahulwagh/Documents/Documents-Rahul-MacBook-Pro/jhooq/ansible-examples/part-14-ansible-vault/pass_file/ansible-vault.pass
b. Run the playbook

ansible-playbook --inventory inventory/ansible-vault/hosts ansible-vault-playbook.yml -e @group_vars/my_vault_with_bas64_pass.yml
<!--  -->