#!/bin/sh

#
# postgres
#

export PATH=$PATH:/bin/
export PGDATA=$PWD/postgres
export PGHOST=/tmp/postgres
export PGLOG=$PWD/postgres/LOG
export PGDATABASE=postgres
export DATABASE_URL="postgresql:///postgres?host=$PGHOST"

#
# app
#

export TODO_DEFINE_APP_CAP_ENV="dev";
export TODO_DEFINE_APP_CAP_LOG_FORMAT="Bracket"; # Bracket | JSON
export TODO_DEFINE_APP_CAP_LIBPQ_CONN_STR="postgresql://nixbld1@/p88lnd";
export TODO_DEFINE_APP_CAP_ENDPOINT_PORT="4000";
