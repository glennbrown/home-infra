Certbot Cloudfare
=========

Use Cloudflare DNS for wildcard certbot generation

Requirements
------------

- Cloudflare DNS Zone
- Cloudflare API Token (preferred) or Cloudflare Global API Key [Certbot Cloudflare DNS Docs](https://certbot-dns-cloudflare.readthedocs.io/en/stable/)
- Wildcard domain setup (for wildcard certs) [*.domain.com or *.subdomain.domain.com]

Role Variables
--------------
***Define these variables in group_vars or host_vars***

If you are using Global API Key

    certbot_cloudflare_email: "cloudflare@example.com"
    certbot_cloudflare_api_key: ''

If you are using API token which currently only works with Snap version
    certbot_cloudflare_api_token: ''

***Secrets should be stored in Ansible Vault or some other secrets management platform, do not commit secrets plain text!***

Certificates to generate which can include wildcards or not

    certbot_certs:
      - email: {{certbot_cloudflare_email}}
        domains:
          - example.com
          - *.example.com
      - email: {{certbot_cloudflare_email}}
        domains:
          - example2.com
          - *.example2.com
      
Let's Encrypt server to use, defaults to test.

    certbot_cloudflare_acme_server: "{{ certbot_cloudflare_acme_test }}"
    certbot_cloudflare_acme_server: "{{ certbot_cloudflare_acme_live }}"

The create command which instructs the role to use DNS-01 Challenge.

    certbot_create_command: "{{ certbot_script }} certonly --noninteractive --dns-cloudflare --dns-cloudflare-propagation-seconds 60 --agree-tos --email {{ cert_item.email | default(certbot_admin_email) }} -d {{ cert_item.domains | join(',') }}"

Dependencies
------------

- geerlingguy.certbot

Author Information
------------------

This role was created by [glennbrown](http://github.com/glennbrown) and is based on this role by [Michael Porter](https://github.com/michaelpporter/ansible-role-certbot-cloudflare)