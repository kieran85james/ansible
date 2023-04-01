help:
	@echo "Usage: 'make COMMAND'"

encrypt:
	ansible-vault encrypt --vault-password-file ~/.vault_key ./roles/base/vars/main.yml && ansible-vault encrypt --vault-password-file ~/.vault_key ./roles/workstation/files/users/kieranjames/ssh_client_config

decrypt:
	ansible-vault decrypt --vault-password-file ~/.vault_key ./roles/base/vars/main.yml && ansible-vault decrypt --vault-password-file ~/.vault_key ./roles/workstation/files/users/kieranjames/ssh_client_config