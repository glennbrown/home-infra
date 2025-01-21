export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

# Recipes
@default:
  just --list

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

### Run/Builds
build_pve:
	ansible-playbook -u root -b run.yml --limit pve --ask-pass

build +HOST:
	ansible-playbook -b run.yml --limit {{HOST}}

# Docker Container Updates
docker:
    ansible-playbook docker.yml 

# just run HOST TAGS
run HOST *TAGS:
    ansible-playbook -b run.yml --limit {{HOST}} {{TAGS}}

# git submodule - repo URL + optional local folder name
add-submodule URL *NAME:
    #!/usr/bin/env sh
    if [ -z "{{NAME}}" ]; then
        # Extract repo name from URL if no name provided
        basename=$(basename "{{URL}}" .git)
        git submodule add {{URL}} "roles/${basename}"
        git submodule update --init --recursive
        git add .gitmodules "roles/${basename}"
        git commit -m "Adds ${basename} as a submodule"
    else
        git submodule add {{URL}} "roles/{{NAME}}"
        git submodule update --init --recursive
        git add .gitmodules "roles/{{NAME}}"
        git commit -m "Adds {{NAME}} as a submodule"
    fi

# Ansible Vault Decrypt
decrypt:
    ansible-vault decrypt group_vars/all/vault.yml

# Ansible Vault Encrypt
encrypt:
    ansible-vault encrypt group_vars/all/vault.yml

### Bootstrap/Setup
bootstrap_lxc +HOST:
	ansible-playbook -u root -b bootstrap.yml --limit {{HOST}}

bootstrap +HOST:
	ansible-playbook -b bootstrap.yml --limit {{HOST}}