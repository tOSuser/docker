# Coturn

Turn and stun servers docker container based on https://github.com/coturn/coturn/blob/master/docker/coturn/README.md.

## Updates
* Updated with an entrypoint

## How to use

Build an image

```bash
docker build -t coturn_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t coturn_image .
```

Run a nginx instance:

```bash
docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local -v

docker exec -it coturn sh
```
