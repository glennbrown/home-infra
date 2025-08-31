# Ansible Role: Install ctop

An ansible role to install [ctop](https://github.com/bcicen/ctop)

## Features

- Installation of the `ctop` go binary.
- Updating if there is an update and version is not pinned.

## Configuration

This role has a number of variables that can be configured.

| Variable                      | Description                                              | Default           |
| ----------------------------- | -------------------------------------------------------- | ----------------- |
| **ctop_install_directory**    | Directory that ctop will be installed into               | /usr/local/bin    |
| **ctop_download_latest**      | Whether to download the latest version from Github       | true              |
| **ctop_pinned_version**       | Desired version of ctop, overriden by previous var       | 0.7.7             |

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
ctop_download_latest: false
ctop_pinned_version: 0.7.7
```

>[!NOTE]
>By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.

## Github API

This role utilizes the GitHub API to determine the latest release available.  By default, the role utilizes unauthenticated requests, which are [limited by GitHub](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting) to 60 requests per hour.  Requests are associated with the originating IP address.  For most usecases, this is not an issue.  However, you may find yourself rate limited.  If you authenticate, you can make 5,000 requests per hour.

To authenticate, you must obtain a [Personal Access Token](https://github.com/settings/tokens/new).  The token does not need any scopes selected.  Then add the following variables:

```yaml
github_api_user: YOURUSER
github_api_pass: YOUR_TOKEN
github_api_auth: yes
```
