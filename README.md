# pretixSCAN Proxy docker

A docker compose based deployment of [pretixSCAN Proxy](https://github.com/pretix/pretixscan-proxy)

### Building
First you need to build the pretixSCAN proxy container. 
If you want to change the version, change `PRETIXSCAN_PROXY_VERSION` and `PRETIXSCAN_PROXY_CHECKSUM`.
(See [configuration](#configuration) for details)

Then you can build the container like this:

    docker compose build


### Configuration 
Configuration is done via environment variables.
Copy the `example.env` file to `.env` and adapt it to your needs.
The only setting you need to change is `PRETIXSCAN_PROXY_BASEURL` if you are using your own reverse proxy or `PRETIXSCAN_PROXY_HOSTNAME` if you are using caddy.
You also **really** should change `PRETIXSCAN_PROXY_ADMINAUTH`.

| Environment Variable | Default Value | Description |
| -------------------- | ------------- | ----------- |
| PRETIXSCAN_PROXY_VERSION | `2.6.2` | Version of pretixSCAN proxy to use. |
| PRETIXSCAN_PROXY_CHECKSUM | `sha256:8d51688094c8d6a44ca85df9d7b70c200c0000f3115f7d9bcf70b8213e6b9f76` | Checksum of the jar file |
| PRETIXSCAN_PROXY_DATABASE | `jdbc:postgresql://postgres/${POSTGRES_DB}?user=${POSTGRES_USER}&password=${POSTGRES_PASSWORD}` | PostgreSQL connection URL |
| PRETIXSCAN_PROXY_ADMINAUTH | `admin:admin` | user:pass for management interface |
| PRETIXSCAN_PROXY_AUTO_OFFLINE_MODE | `on` | See [prexiSCAN proxy docs](https://github.com/pretix/pretixscan-proxy?tab=readme-ov-file#config-options) |
| PRETIXSCAN_PROXY_BASEURL | `https://${PRETIXSCAN_PROXY_HOSTNAME}:${PRETIXSCAN_PROXY_PORT}` | Base URL the proxy will be reachable at |
| PRETIXSCAN_PROXY_HOSTNAME | `localhost` | hostname part of base URL and hostname used by caddy |
| PRETIXSCAN_PROXY_PORT | `443` | port part of base URL and port caddy listens at |
| PRETIXSCAN_PROXY_ADMIN_BIND | `127.0.0.1:7000` | port (and ip) the container is reachable by |
| POSTGRES_DB | `scanproxy` | PostgreSQL database name |
| POSTGRES_USER | `scanproxy` | PostgeSQL user to create and use |
| POSTGRES_PASSWORD | `scanproxy` | PostgeSQL password to create and use |


### Running

You can run this setup either with your own reverse proxy in front for TLS termination or with caddy. Caddy automatically provisions a Let's Encrypt TLS certificate via HTTP-1 validation.

To use your own reverse proxy, start the stack with:

    docker compose up -d


To use caddy start the stack with

    docker compose -f docker-compose.yaml -f docker-compose.caddy.yaml up -d
