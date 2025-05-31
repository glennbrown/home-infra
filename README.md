# Introduction

This repo contains the code I use for deploying and managing servers mostly running on Proxmox. Ansible is the primary way I deploy and manage things.

## Requirements

- Python 3
- [`ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) 
    - My prefered installation method is a virtualenv with pip
- [`pre-commit`](https://pre-commit.com)
    - My prefered installation method is homebrew
- [`just`](https://github.com/casey/just)
    - My preferred installation is from homebrew on MacOS

## Explanation of systems:

Most of my servers are named after norse mythology characters or from the mnemonic wordlist.

| Name     | Type     | OS            | Description                       |
| -------- | -------- | ------------- | --------------------------------- |
| odin     | Physical | Proxmox       | Primary Server                    |
| thor     | VM       | Ubuntu 24.04  | Internal web server/reverse proxy |
| celtic   | VM       | Debian 12     | Cloud VPS                         |

## just usage

### Deployment

* `just install` - Uses pre-commit to install the git hook that prevents commiting an unencrypted Ansible vault file.
* `just build_pve` - Create's all LXC's or VM's and configures proxmox host.
* `just bootstrap_lxc` - Does the base setup of a LXC container using root.
* `just bootstrap` - Does the base setup of a VM using normal account.
* `just build` - Sets up a host

> [!TIP]
> You can pass a hostname to the bootstrap, bootstrap_lxc or build options.

### Ansible Vault

* `just encrypt` - Encrypts the Ansible Vault
* `just decrypt` - Decrypts the Ansible Vault

### Updates

* `just docker` - Prompts for host and containers, leverage the community.docker modules to pull, update and then prune containers.
