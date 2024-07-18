# MongoDB

MongoDB docker container based on alpine.

## Updates
* Updated with an entrypoint

## How to use

Build an image

```bash
docker build -t mongodb_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t mongodb_image .
```

Run a cli instance:

```bash
docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local

docker exec -it mongodb sh
```
