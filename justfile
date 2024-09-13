#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

# Recipes
@default:
  just --list

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

ansible_dir := "ansible"

# Docker Container Updates
docker:
    ansible-playbook docker.yml 

# just run HOST TAGS
run HOST *TAGS:
    ansible-playbook -b run.yml --limit {{HOST}} {{TAGS}}

# Roles and Collections Repos
# optionally use --force to reinstall all requirements
reqs *FORCE:
    ansible-galaxy install -r requirements.yml {{FORCE}}

# Ansible Vault Decrypt
decrypt:
    ansible-vault decrypt vars/vault.yml

# Ansible Vault Encrypt
encrypt:
    ansible-vault encrypt vars/vault.yml

