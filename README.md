# OutsideTheRing Chat
Element-Matrix  chat template for spinning up a simple server.

### Requirements
 - Docker and Docker Compose
 - Git
 - Text Editor or IDE
 - Make

### Running On A Server
1. Spin up a Linux server somewhere.
2. Install Docker, Git, and Make.
3. `git clone` this repo.
4. In `./admin/config.json`, replace the address with your domain name.
5. In `./coturn/turnserver.conf` enter relevant values.
6. In `./element/element-config.json`: add correct items for `base_url`'s and `server_name`. Also, update `auth_footer_links` as needed
7. Update `./matrix/homeserver.yaml` as needed and replace all instances of `0.0.0.0` with domain name.
8. Change `server_name` and cert paths in `./nginx/default.conf`.
9. Update the docker compose file `certbot` command with email and domain name.
10. Run `make fresh_install`.
11. Run `make gen_user` to create admin account.

**NOTE**: Use `watchtower` at your own risk.

### Running Locally
1. Install Docker, Git, and Make.
2. In `docker-compose.yaml` comment `watchtower` and `certbot`.
3. In `./nginx/default.conf`, comment ssl cert paths and change the server listening on `443` to `80`.
4. `make fresh_install`.
5. Run `make gen_user` to create admin account.

### TODOs
 - Different compose file and nginx config for running locally, or template nginx container with appropriate env vars 
 - Clean nginx config
 - Consent Tracking: [Docs](https://matrix-org.github.io/synapse/latest/consent_tracking.html)
 - Custom Home: [Docs](https://github.com/element-hq/element-web/blob/develop/docs/custom-home.md)
 - Privacy Policy and TOS
 - Glances for monitoring
 - Linode stack script
 - Kubernetes

### Useful Links

| Description | Link |
| :--- | :--- |
| Matrix Docs | https://matrix-org.github.io/synapse/latest/ |
| Element Docs | https://github.com/element-hq/element-web/tree/develop/docs |