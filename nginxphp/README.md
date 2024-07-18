# nginxphp

nginx + php docker container based on https://github.com/TrafeX/docker-php-nginx.

## Updates
* Update to Alpine 3.19
* php 8.3
* nginx 1.24

## How to use

Build an image

```bash
docker build -t nginxphp_image .
# or for arm/v7
docker build --platform linux/arm/v7 -t nginxphp_image .
```

Run an nginxphp instance:

```bash
docker run -d --volume=$HOME/docker-data/nginx/www:/var/www/html --name nginxphp --privileged -p 8080:8080 nginxphp_image

docker compose up -d
docker compose down --rmi local
# or
#docker compose -f docker-compose.yml up -d
#docker compose f docker-compose.yml down --rmi local

docker exec -it nginxphp sh
```
