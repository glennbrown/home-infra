export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

# Recipes
@default:
  just --list

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

# pre-commit install
install-commit-hook:
    pre-commit install

# Ansible Galaxy Roles/Collections
ansible-galaxy-install:
    ansible-galaxy install -r galaxy-requirements.yml --force

# Bootstrap a new host
bootstrap +HOST:
	ansible-playbook run.yml --tags bootstrap --limit {{HOST}}

# Run/Builds
build HOST *TAGS:
	ansible-playbook run.yml --limit {{HOST}} {{TAGS}}

# Update Docker Compose on a host
compose +HOST:
    ansible-playbook run.yml --tags compose --limit {{HOST}}

# Docker Container updates
docker-update:
    ansible-playbook docker.yml 

package-update HOST="":
    #!/usr/bin/env sh
    if [ -n "{{HOST}}" ]; then \
        ansible-playbook update.yml --limit "{{HOST}}"; \
    else \
        ansible-playbook update.yml; \
    fi

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
