# mysql-official

mysql-official docker container based on https://hub.docker.com/_/mysql/.

## Updates
* Updated with a new my.cnf

## How to use

Build an image

```bash
docker build -t mysql-official_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t mysql-official_image .
```

Run a mysql-official instance:

```bash
docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local

docker exec -it mysql-official sh
```
