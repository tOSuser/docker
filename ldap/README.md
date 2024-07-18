# cli

ldap docker container based on alpine.

## Updates


## How to use

Build an image

```bash
docker build -t ldap_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t ldap_image .
```

Run a cli instance:

```bash
docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local -v

docker exec -it ldap sh
```
