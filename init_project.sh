echo "init project - start"

set -x
: ${SUPERUSER_PASS}?"need superuser password, SUPERUSER_PASS"}
: ${SUPERUSER_USER}?"need superuse, SUPERUSER_USER"}
: ${PG_USER?"need to set database user PG_USER"}
: ${PG_PASS?"need to set database user password PG_PASS"}
: ${PG_HOST?"need to set database host PG_HOST"}
: ${PG_PORT?"need to set database host PG_PORT"}
: ${PG_DATABASE?"need to set database name PG_DATABASE"}

CREATE_USER="CREATE USER $PG_USER WITH PASSWORD '$PG_PASS';"
CREATE_DB="CREATE DATABASE $PG_DATABASE OWNER $PG_USER;"

export PGPASSWORD=$SUPERUSER_PASS
psql -h $PG_HOST -p $PG_PORT -d postgres -U $SUPERUSER_USER -c "$CREATE_USER"
psql -h $PG_HOST -p $PG_PORT -d postgres -U $SUPERUSER_USER -c "$CREATE_DB"

echo "init project - done"
