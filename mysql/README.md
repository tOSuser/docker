# mysql

mysql docker container based on https://github.com/batlley/alpine-mysql.

## Updates
* Based on alpine 3.19
* Updated with an entrypoint

## How to use

Build an image

```bash
docker build -t mysql_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t mysql_image .
```

Run a mysql instance:

```bash
docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local

docker exec -it mysql sh
```
