#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

ansible_dir := "ansible"

# just run HOST TAGS
run HOST *TAGS:
    cd {{ansible_dir}} && ansible-playbook -b run.yml --limit {{HOST}} {{TAGS}}

# Roles and Collections Repos
# optionally use --force to reinstall all requirements
reqs *FORCE:
    cd {{ansible_dir}} && ansible-galaxy install -r requirements.yml {{FORCE}}

# just vault (encrypt/decrypt/edit/view)
vault ACTION:
    cd {{ansible_dir}} && EDITOR='code --wait' ansible-vault {{ACTION}} vars/vault.yml
