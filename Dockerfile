# Postgres 9.3

# information from: http://amattn.com/2013/09/19/tutorial_postgresql_usage_examples_with_docker.html
FROM tilljoel/ubuntu-base
MAINTAINER Joel Larsson, tilljoel@gmail.com

RUN -get update
RUN apt-get install -y wget
RUN wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update
RUN apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

ADD ./init_postgres.sh /init_postgres.sh
ADD ./init_project.sh /init_project.sh
ADD ./init_superuser.sh /init_superuser.sh
ADD ./allow_all_access.sh /allow_all_access.sh
RUN chmod +x /*.sh
EXPOSE 5432
CMD ["su", "postgres", "--command", "/usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf"]
