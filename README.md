# Postgres image for Docker

Contains Postgres with configuration and some helper-scripts to create
new projects.

# Prepare installation

```bash
sudo su
mkdir /root/postgresdata
docker run -v="/root/postgresdata":"/data" tilljoel/postgres /bin/bash -c ./init_postgres.sh
docker run -e SUPERUSER_USER=joel -e SUPERUSER_PASS=secret -v="/root/postgresdata":"/data" tilljoel/postgres /bin/bash -c ./init_superuser.sh
docker run -e SUPERUSER_USER=joel -e SUPERUSER_PASS=secret -v="/root/postgresdata":"/data" tilljoel/postgres /bin/bash -c ./allow_all_access.sh
```

# Start postgres

```bash
CONTAINER_ID=$(docker run -name postgres -v="/root/postgresdata":"/data" -d tilljoel/postgres)
CONTAINER_IP=$(docker inspect $CONTAINER_ID | grep IPAddress | awk '{ print $2 }' | tr -d ',"')
echo $CONTAINER_IP > /root/.postgres_ip
```

# New project (user+database)


```bash
sudo docker run -e SUPERUSER_USER=joel -e SUPERUSER_PASS=secret -e PG_USER=tilljoel -e PG_PASS=secret -e PG_DATABASE=tilljoeldb -e PG_HOST=CONTAINER_IP -e PG_PORT=5432 -v="/root/postgresdata":"/data" tilljoel/postgres-9.3.0 /bin/bash -c ./init_project.sh
```

