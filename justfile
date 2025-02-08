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

# Run/Builds
build_pve:
	ansible-playbook -u root run.yml --limit pve --ask-pass

build HOST *TAGS:
	ansible-playbook run.yml --limit {{HOST}} {{TAGS}}

# Updates
docker:
    ansible-playbook docker.yml 

update:
    ansible-playbook update.yml --limit odin,thor,wayland,heimdall

update_pve:
    ansible-playbook update.yml --limit pve

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

# Bootstrap/Setup
bootstrap_lxc +HOST:
	ansible-playbook -u root bootstrap.yml --limit {{HOST}}

bootstrap +HOST:
	ansible-playbook bootstrap.yml --limit {{HOST}}

