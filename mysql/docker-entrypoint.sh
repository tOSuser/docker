#!/bin/sh

# Do pre-configurations here
# Check environment variables
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
	MYSQL_ROOT_PASSWORD=mypass
fi

exec "$@"
