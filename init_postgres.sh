echo "init postgress - start"

set -x
cp /etc/postgresql/9.3/main/postgresql.conf /data/postgresql.conf
cp /etc/postgresql/9.3/main/pg_hba.conf /data/pg_hba.conf
sed -i '/^data_directory*/ s|/var/lib/postgresql/9.3/main|/data/main|' /data/postgresql.conf
sed -i '/^hba_file*/ s|/etc/postgresql/9.3/main/pg_hba.conf|/data/pg_hba.conf|' /data/postgresql.conf
sed -i "s/\(external_pid_file = \)'.*'/\1\/data\/9.3-main.pid'/g" /data/postgresql.conf
mkdir -p /data/main
chown postgres /data/*
chgrp postgres /data/*
chmod 700 /data/main
su postgres --command "/usr/lib/postgresql/9.3/bin/initdb -D /data/main"

echo "init postgress - done"
