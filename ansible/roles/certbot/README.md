Certbot
=========

Installs certbot via either pip, package manager or snap and uses Cloudflare DNS Challenge for wildcard cert generation

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
      
Method of how to install certbot, defaults to pip.

    certbot_install_method: snap

Enable certbot's HTTP Strict Transport Security (HSTS)

    certbot_hsts: true

Use Let's Encrypt staging server, defaults to no.

    certbot_testmode: true

The create command which instructs the role to use DNS-01 Challenge. This is defined in the role defaults should not needed to be changed.

    certbot_create_command: >-
      {{ certbot_script }} certonly
      {{ '--hsts' if certbot_hsts else '' }}
      {{ '--test-cert' if certbot_testmode else '' }}
      --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini     --dns-cloudflare-propagation-seconds 60
      --noninteractive --agree-tos
      --email {{ cert_item.email | default(certbot_admin_email) }}
      -d {{ cert_item.domains | join(',') }}
      {{ '--pre-hook /etc/letsencrypt/renewal-hooks/pre/stop_services'
        if certbot_create_stop_services else '' }}
      {{ '--post-hook /etc/letsencrypt/renewal-hooks/post/start_services'
        if certbot_create_stop_services else '' }}

Author Information
------------------

This role was created by [glennbrown](http://github.com/glennbrown) and is based on [Jeff Geerlings](https://github.com/geerlingguy/ansible-role-certbot/tree/master) role and this role by [Michael Porter](https://github.com/michaelpporter/ansible-role-certbot-cloudflare)