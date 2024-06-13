#!/bin/bash

set -e

if [ "$1" = 'mysqlrouter' ]; then
    if [[ -z $MYSQL_HOST || -z $MYSQL_PORT || -z $MYSQL_USER || -z $MYSQL_PASSWORD ]]; then
	    echo "We require all of"
	    echo "    MYSQL_HOST"
	    echo "    MYSQL_PORT"
	    echo "    MYSQL_USER"
	    echo "    MYSQL_PASSWORD"
	    echo "to be set."
      echo ""
	    echo "Exiting."
	    exit 1
    fi

    PASSFILE=$(mktemp)
    echo "$MYSQL_PASSWORD" > "$PASSFILE"
    if [ -z $MYSQL_CREATE_ROUTER_USER ]; then
      echo "$MYSQL_PASSWORD" >> "$PASSFILE"
      MYSQL_CREATE_ROUTER_USER=1
      echo "[Entrypoint] MYSQL_CREATE_ROUTER_USER is not set, Router will generate a new account to be used at runtime."
      echo "[Entrypoint] Set it to 0 to reuse $MYSQL_USER instead."
    elif [ "$MYSQL_CREATE_ROUTER_USER" = "0" ]; then
      echo "$MYSQL_PASSWORD" >> "$PASSFILE"
      echo "[Entrypoint] MYSQL_CREATE_ROUTER_USER is 0, Router will reuse $MYSQL_USER account at runtime"
    else
      echo "[Entrypoint] MYSQL_CREATE_ROUTER_USER is not 0, Router will generate a new account to be used at runtime"
    fi

    if [ $(id -u) = "0" ]; then
      opt_user=--user=mysqlrouter
    fi
    if [ "$MYSQL_CREATE_ROUTER_USER" = "0" ]; then
        echo "[Entrypoint] Succesfully contacted mysql server at $MYSQL_HOST. Trying to bootstrap reusing account \"$MYSQL_USER\"."
        mysqlrouter --bootstrap "$MYSQL_USER@$MYSQL_HOST:$MYSQL_PORT" --directory /tmp/mysqlrouter --force --account-create=never --account=$MYSQL_USER $opt_user $MYSQL_ROUTER_BOOTSTRAP_EXTRA_OPTIONS < "$PASSFILE" || exit 1
    else
        echo "[Entrypoint] Succesfully contacted mysql server at $MYSQL_HOST. Trying to bootstrap."
        mysqlrouter --bootstrap "$MYSQL_USER@$MYSQL_HOST:$MYSQL_PORT" --directory /tmp/mysqlrouter --force $opt_user $MYSQL_ROUTER_BOOTSTRAP_EXTRA_OPTIONS < "$PASSFILE" || exit 1
    fi

    sed -i -e 's/logging_folder=.*$/logging_folder=/' /tmp/mysqlrouter/mysqlrouter.conf
    echo "[Entrypoint] Starting mysql-router."
    rm -f "$PASSFILE"
    exec "$@" --config /tmp/mysqlrouter/mysqlrouter.conf

else
    exec "$@"
fi
