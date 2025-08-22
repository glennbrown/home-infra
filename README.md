# Introduction

This repo contains the code I use for deploying and managing my home server and cloud VPS. Ansible is the primary way I deploy and manage things.

## Requirements

- Python 3.x
- [`ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) - *My prefered installation method is pipx or homebrew*
- [`pre-commit`](https://pre-commit.com) - *My prefered installation method is homebrew*
- [`just`](https://github.com/casey/just) - *My preferred installation is from homebrew on MacOS*

## Explanation of systems

Most of my servers are named after norse mythology characters or from the mnemonic wordlist.

| Name     | Type     | OS            | Description       |
| -------- | -------- | ------------- | ----------------- |
| odin     | Physical | Ubuntu 24.04  | Custom Server     |
| celtic   | VM       | Debian 12     | Cloud VPS         |

## just usage

### Deployment

- `just install` - Uses pre-commit to install the git hook that prevents commiting an unencrypted Ansible vault file.
- `just ansible-galaxy-install` - Install's Requirements from Ansible Galaxy
- `just bootstrap` - Does the base setup of a VM/LXC (User, Group, SSH keys, etc).
- `just add-submodule REPO NAME` - Installs a git repo as a submodule in roles folder with the name specified, if you do not specify it will extract the damn from the url.
- `just build` - Sets up a host

> [!TIP]
> You can pass a hostname to the bootstrap or build options.

### Ansible Vault

- `just ansible-vault ACTION` - Encrypt or descrypt the Ansible Vault

### Updates

- `just docker-update` - Update Docker containers, it will prompt for host and containers
