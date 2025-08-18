export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

# Recipes
@default:
  just --list

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

# pre-commit install
install:
    pre-commit install

# Ansible Galaxy Roles/Collections
ansible-galaxy-install:
    ansible-galaxy install -r galaxy-requirements.yml --force

# Run/Builds
build HOST *TAGS:
	ansible-playbook run.yml --limit {{HOST}} {{TAGS}}

# Docker Container updates
docker-update:
    ansible-playbook docker.yml 

update:
    ansible-playbook update.yml --limit odin,thor,wayland,heimdall

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
ansible-vault ACTION *ARGS:
    ansible-vault {{ ACTION }} group_vars/all/vault.yml

# Bootstrap a new host
bootstrap +HOST:
	ansible-playbook run.yml --tags bootstrap --limit {{HOST}}
