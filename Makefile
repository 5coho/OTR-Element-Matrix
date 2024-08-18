NGINX_CONTAINER = nginx
ELEMENT_CONTAINER = element
SYNAPSE_CONTAINER = synapse
ADMIN_CONTAINER = synapse-admin
COTURN_CONTAINER = coturn
CERTBOT_CONTAINER = certbot
WATCHTOWER_CONTAINER = watchtower
POSTGRES_CONTAINER = postgres

EMAIL = < email goes here for cert >
DOMAIN = < domaine name goes here >

help:  ##		Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

fresh_install: ##	Run the app locally
	@docker compose up -d

restart: ##		Restart all Containers
	@docker compose restart

kill: ##		Kill the app containers
	@docker compose kill

list: ##		List running containers
	@docker compose ps

clean: kill ##		Cleans up docker
	@docker system prune --all --volumes --force


# ------------------- SYNAPSE INIT-------------------------------------
gen_homeserver: ##	Generates homeserver.yaml (not needed)
	@sudo docker run -it --rm \
    -v "./matrix:/data" \
    -e SYNAPSE_SERVER_NAME=OutsideTheRing \
    -e SYNAPSE_REPORT_STATS=no \
    matrixdotorg/synapse:latest generate

gen_user: ##		Create a Synapse User
	@docker compose exec -it ${SYNAPSE_CONTAINER} register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008


# ------------------- CERTS -------------------------------------------
gen_cert: ##		Generate an TLS/SSL cert using certbot
	@docker compose run ${CERTBOT_CONTAINER} certonly --webroot -w /var/www/certbot --keep-until-expiring --email ${EMAIL} -d ${DOMAIN} --agree-tos

renew_cert: ##		Renew lets encrypt cert
	@docker compose run ${CERTBOT_CONTAINER} renew -d ${DOMAIN}

renew_cert_dryrun: ##	Renew lets encrypt cert
	@docker compose run ${CERTBOT_CONTAINER} renew -d ${DOMAIN} --dry-run

view_certs: ##		Renew lets encrypt cert
	@docker compose run ${CERTBOT_CONTAINER} certificates


# ------------------- CONTAINER SHELLS ---------------------------------
shell_nginx: ##		Opens NGINX container shell
	@docker compose exec -it ${NGINX_CONTAINER} /bin/bash

shell_element: ##	Opens Element container shell
	@docker compose exec -it ${ELEMENT_CONTAINER} sh

shell_synapse: ##	Opens Synapse container shell
	@docker compose exec -it ${SYNAPSE_CONTAINER} /bin/bash

shell_admin: ##		Opens Synapse-Admin container shell
	@docker compose exec -it ${ADMIN_CONTAINER} sh

shell_coturn: ##		Opens Coturn container shell
	@docker compose exec -it ${COTURN_CONTAINER} sh

shell_pg: ##		Opens PostgreSQL container shell
	@docker compose exec -it ${POSTGRES_CONTAINER} /bin/bash


# ------------------- CONTAINER LOGS -----------------------------------
logs_nginx: ##		Opens NGINX container logs
	@docker compose logs -f ${NGINX_CONTAINER}

logs_element: ##		Opens Element container logs
	@docker compose logs -f ${ELEMENT_CONTAINER}

logs_synapse: ##		Opens Synapse container logs
	@docker compose logs -f ${SYNAPSE_CONTAINER}

logs_admin: ##		Opens Synapse-Admin container logs
	@docker compose logs -f ${ADMIN_CONTAINER}

logs_coturn: ##		Opens Coturn container logs
	@docker compose logs -f ${COTURN_CONTAINER}

logs_certbot: ##		Opens Certbot container logs
	@docker compose logs -f ${CERTBOT_CONTAINER}

logs_watchtower: ##	Opens Watchtower container logs
	@docker compose logs -f ${WATCHTOWER_CONTAINER}

logs_pg: ##		Opens PostgreSQL container logs
	@docker compose logs -f ${POSTGRES_CONTAINER}


# ------------------- CONTAINER RESTARTS -------------------------------
restart_nginx: ##	restarts the NGINX container
	@docker compose restart ${NGINX_CONTAINER}

restart_element: ##	restarts the Element container
	@docker compose restart ${ELEMENT_CONTAINER}

restart_synapse: ##	restarts the Synapse container
	@docker compose restart ${SYNAPSE_CONTAINER}

restart_admin: ##	restarts the Synapse-Admin container
	@docker compose restart ${ADMIN_CONTAINER}

restart_coturn: ##	restarts the Coturn container
	@docker compose restart ${COTURN_CONTAINER}

restart_certbot: ##	restarts the Certbot container
	@docker compose restart ${CERTBOT_CONTAINER}

restart_watchtower: ##	restarts the Watchtower container
	@docker compose restart ${WATCHTOWER_CONTAINER}

restart_pg: ##		restarts the PostgreSQL container 
	@docker compose restart ${POSTGRES_CONTAINER}