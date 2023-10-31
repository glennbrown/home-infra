#!/bin/bash

set -e 

export NODE_NO_WARNINGS=1
VAULT_ANSIBLE_NAME="Ansible Vault"

bw get password "${VAULT_ANSIBLE_NAME}"