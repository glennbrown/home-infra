# Install VueTorrent Web UI

An ansible role to install [VueTorrent](https://github.com/VueTorrent/VueTorrent) webui for qBittorrent. This replaces the stock qBittorrent webui with one based on Vue.js

## Features

- Downloads VueTorrent and places into desired location
- Updates if there is an update available and version is not pinned

## Configuration

Below are the configurable variables.
> Note: That `vuetorrent_force_install` defaults to `false`. The purpose is to force an install of a pinned version.

```yaml
vuetorrent_version: v2.7.3
vuetorrent_force_install: false
vuetorrent_install_location: /mnt/nvme1tb/appdata/qbittorrent/themes
```
> Note: The `v` is necessary

## Github API

This role utilizes the GitHub API to determine the latest release available.  By default, the role utilizes unauthenticated requests, which are [limited by GitHub](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting) to 60 requests per hour.  Requests are associated with the originating IP address.  For most usecases, this is not an issue.  However, you may find yourself rate limited.  If you authenticate, you can make 5,000 requests per hour.

To authenticate, you must obtain a [Personal Access Token](https://github.com/settings/tokens/new).  The token does not need any scopes selected.  Then add the following variables:

```
github_api_user: glennbrown
github_api_pass: YOUR_TOKEN
github_api_auth: yes
```

## Configuring qBittorrent

You will need to update the configuration in qBittorrent to path you set.