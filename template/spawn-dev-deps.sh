#!/bin/sh

set -m

#
# postgres
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

postgres-sh -c 'createdb p88lnd'

#
# done
#

echo "shell hook executed!"

