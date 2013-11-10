# Postgres 9.3.0 image for Docker

Contains Postgres 9.3.0 with configuration and some helper-scripts to create
new projects.

```bash
FROM amattn/postgresql-9.3.0
MAINTAINER Joel Larsson, tilljoel@gmail.com

RUN mkdir /root/postgresdata
ADD ./init_postgres.sh /init_postgres.sh
ADD ./init_project.sh /init_project.sh
ADD ./init_superuser.sh /init_superuser.sh
ADD ./allow_all_access.sh /allow_all_access.sh
RUN chmod +x /*.sh
EXPOSE 5432
```

# Prepare installation

```bash
sudo docker run -v="/root/postgresdata":"/data" tilljoel/postgresql-9.3.0 /bin/bash -c ./init_postgres.sh
sudo docker run -e SUPERUSER_USER=joel -e SUPERUSER_PASS=secret -v="/root/postgresdata":"/data" tilljoel/postgresql-9.3.0 /bin/bash -c ./init_superuser.sh
sudo docker run -e SUPERUSER_USER=joel -e SUPERUSER_PASS=secret -v="/root/postgresdata":"/data" tilljoel/postgresql-9.3.0 /bin/bash -c ./allow_all_access.sh
```

# Start postgres

```bash
CONTAINER_ID=$(docker run -name postgres -v="/root/postgresdata":"/data" -d tilljoel/postgresql-9.3.0 su postgres --command "/usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf")
CONTAINER_IP=$(docker inspect $CONTAINER_ID | grep IPAddress | awk '{ print $2 }' | tr -d ',"')
```

# New project (user+database)

First fetch the 
```bash
# Make sure CONTAINER_IP is set and all other variables
sudo docker run -e SUPERUSER_USER=joel -e SUPERUSER_PASS=secret -e PG_USER=tilljoel -e PG_PASS=secret -e PG_DATABASE=tilljoeldb -e PG_HOST=CONTAINER_IP -e PG_PORT=5432 -v="/root/postgresdata":"/data" tilljoel/postgresql-9.3.0 /bin/bash -c ./init_project.sh
```

