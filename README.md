# Introduction

This repo contains the code I use for deploying and managing my home servers and cloud VPS. Ansible is the primary way I deploy and manage things.

## Requirements

- Python 3.x
- [`ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) - *My prefered installation method is pipx or homebrew*
- [`pre-commit`](https://pre-commit.com) - *My prefered installation method is homebrew*
- [`just`](https://github.com/casey/just) - *My preferred installation is from homebrew on MacOS*

## Explanation of systems

Most of my servers are named after norse mythology characters or from the [mnemonic wordlist][1).

| Name      | Type     | OS          | Description                   |
| --------- | -------- | ----------- | ----------------------------- |
| pve-01    | Physical | Proxmox     | Custom Server                 |
| odin      | LXC      | Debian      | Media Servers (Plex, etc)     |
| bifrost   | VM       | Debian      | Media distribution/collection |
| thor      | VM       | Debian      | Nginx Reverse Proxy           | 
| celtic    | VM       | Debian      | Cloud VPS                     |

## just usage

### Deployment

- `just install-commit-hook` - Uses pre-commit to install the git hook that prevents commiting an unencrypted Ansible vault file.
- `just ansible-galaxy-install` - Install's Requirements from Ansible Galaxy
- `just bootstrap` - Does the base setup of a VM/LXC (User, Group, SSH keys, etc).
- `just build` - Sets up a host, you can tags or skip-tags
- `just compose` - Updates Docker Compose file on a host
- `just add-submodule REPO NAME` - Installs a git repo as a submodule in roles folder with the name specified, if you do not specify it will extract the damn from the url.

> [!TIP]
> You can pass a hostname to the bootstrap or build options.

### Ansible Vault

- `just ansible-vault ACTION` - Encrypt or descrypt the Ansible Vault

### Updates

- `just docker-update` - Update Docker containers, it will prompt for host and containers
- `just package-update` - Update apt packages on hosts, you can pass comma seperate hosts to limit it

[1](https://mnx.io/blog/a-proper-server-naming-scheme/)
