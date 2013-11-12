# Postgres 9.3

# information from: http://amattn.com/2013/09/19/tutorial_postgresql_usage_examples_with_docker.html
FROM tilljoel/ubuntu-base
MAINTAINER Joel Larsson, tilljoel@gmail.com

ADD ./init_postgres.sh /init_postgres.sh
ADD ./init_project.sh /init_project.sh
ADD ./init_superuser.sh /init_superuser.sh
ADD ./allow_all_access.sh /allow_all_access.sh
RUN chmod +x /*.sh
EXPOSE 5432
CMD ["su", "postgres", "--command", "/usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf"]
