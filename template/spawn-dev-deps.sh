#!/bin/sh

set -m

#
# Postgres
#

if [[ $EUID -ne 0 ]]; then
    alias postgres-sh="sh"
else
    alias postgres-sh="su -m nixbld1"
fi

if [ ! -d $PGHOST ]; then
  echo 'initializing postgresql workspace...'
  postgres-sh -c "mkdir -p $PGHOST"
fi
if [ ! -d $PGDATA ]; then
  echo 'initializing postgresql database...'
  postgres-sh -c 'initdb $PGDATA --auth=trust >/dev/null'
fi
echo "starting postgres..."
postgres-sh -c 'pg_ctl start -l $PGLOG -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"'

# NOTE : some Postgres bullshit - it crashes if createdb is executed too soon
echo "sleeping for 3s to prevent postgres/createdb race condition..."
sleep 3;

postgres-sh -c 'createdb TODO_DEFINE_APP'

#
# done
#

echo "shell hook executed!"

