echo "init superuser - start"

set -x
: ${SUPERUSER_USER?"need to set superuser user SUPERUSER_USER"}
: ${SUPERUSER_PASS?"need to set superuser password SUPERUSER_PASS"}

su postgres --command "/usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf" &
su postgres -c "psql -c \"CREATE ROLE $SUPERUSER_USER SUPERUSER LOGIN PASSWORD '$SUPERUSER_PASS';\""
su postgres --command '/usr/lib/postgresql/9.3/bin/pg_ctl --pgdata=/data/main stop'

echo "init superuser - done"
