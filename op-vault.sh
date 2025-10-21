#!/bin/zsh
# Retrieve Ansible Vault password from 1Password, using the 1Password CLI with a service account
# https://developer.1password.com/docs/service-accounts/
set -e

# Load 1Password Service Account Token
source ~/.op-service-account

# Item and Vault names
OP_VAULT="Ansible Secrets"
OP_ITEM="Ansible Vault"

op item get --vault "$OP_VAULT" --format json "$OP_ITEM" |jq '.fields[] | select(.id=="password").value' | tr -d '"'
