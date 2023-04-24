#!/bin/bash
set -e

BECOME_PASSWORD="Ansible Become"

op item get --format json "$BECOME_PASSWORD" | jq '.fields[] | select(.id=="password").value' | tr -d '"'