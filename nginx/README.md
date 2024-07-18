# nginx

nginx docker container based on https://hub.docker.com/_/nginx/.

## Updates
* Based on alpine_slim
* Updated with an entrypoint

## How to use

Build an image

```bash
docker build -t nginx_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t nginx_image .
```

Run a nginx instance:

```bash
docker run -d --volume=$HOME/docker-data/nginx/www:/var/www/html --name nginxphp --privileged -p 8080:80 nginx_image

docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local

docker exec -it nginxphp sh
```
