# CollaboraOnline

Turn and stun servers docker container based on https://github.com/CollaboraOnline/online/blob/master/docker/from-packages/Dockerfile.

## Updates

## How to use

Build an image

```bash
docker build -t collabora_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t collabora_image .
```

Run a nginx instance:

```bash
docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local -v

docker exec -it collabora sh
```
