# Docker composer files

## How to use

To build a compose file:

```bash
docker compose -f <compose file name> up -d
```

To stop and removing all file create by a compose up (included images)

```bash
docker compose -f <compose file name> down --rmi local
```

## Available compose files
### ocserv vpn
Create a ocserv vpn by running two containers, ocserv and bind9, and creating a network named `vpnnetwork`

```bash
docker compose -f docker-compose-vpn.yaml up -d
docker compose -f docker-compose-vpn.yaml down --rmi local -v
```

### ocserv vpn+
Create a ocserv vpn by running 4 containers, ocserv, bind9, nginx and LDAP, and creating a network named `vpnnetwork`

```bash
docker compose -f docker-compose-vpnplus.yaml up -d
docker compose -f docker-compose-vpnplus.yaml down --rmi local -v
```


### nginx php
Create a nginx-vpn by running 2 containers, nginx and php-fpm, and creating a network named `webnetwork`

```bash
docker compose -f docker-compose-nginxphpfpm.yaml up -d
docker compose -f docker-compose-nginxphpfpm.yaml down --rmi local -v
```

### nginx php mysql
Create a nginx-vpn by running 4 containers, nginx, php-fpm, mysql and cli, and creating a network named `webnetwork`

```bash
docker compose -f docker-compose-nginxphpmysql.yaml up -d
docker compose -f docker-compose-nginxphpmysql.yaml down --rmi local -v
```

### nginx php mysql +
Create a nginx-vpn by running 5 containers, nginx, php-fpm, mysql, LDAP and cli, and creating a network named `webnetwork`

```bash
docker compose -f docker-compose-nginxphpmysqlplus.yaml up -d
docker compose -f docker-compose-nginxphpmysqlplus.yaml down --rmi local -v
```

### cloud
Create a nginx-vpn by running 6 containers, nginx, php-fpm, mysql, LDAP , coturn and cli, and creating a network named `webnetwork`

```bash
docker compose -f docker-compose-nginxphpmysqlplus.yaml up -d
docker compose -f docker-compose-nginxphpmysqlplus.yaml down --rmi local -v
```

### All in one
Create a nginx-vpn by running 9 containers, nginx, php-fpm, mysql, LDAP, ocserv, bind9 , coturn and cli and lam, and creating a network named `webnetwork`

```bash
docker compose -f docker-compose-allinone.yaml up -d
docker compose -f docker-compose-allinone.yaml down --rmi local -v
```
