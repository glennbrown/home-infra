#!/bin/bash
set -e

VAULT_ANSIBLE_NAME="Ansible Vault"

op item get --format json "$VAULT_ANSIBLE_NAME" |jq '.fields[] | select(.id=="password").value' | tr -d '"'
