# Dockerfile: PostgreSQL on Fedora

A fedora based postgres container that allows for scripts to be executed on first boot.

## Build and Run

### Build
```
docker build --tag fedora/postgres .
```

### Run
```
PGSQL_HOST_HOME=/pgsql/dir/on/host
PGSQL_HOST_PORT=5432

docker run \
    -p 5432:${PGSQL_HOST_PORT} \
    -v ${PGSQL_HOST_HOME}:/var/lib/pgsql
    fedora/postgres
```

### Post-init scripts
By default, no scripts are executed, these can be run by using `-v ${SCRIPT_DIR}:/usr/share/pgsql-post-init` on initial run. To re-run scripts remove the data directory.

See associated [README](https://github.com/abn/dockerfiles/blob/master/fedora-postgres/assets/pgsql-post-init/README.md) for more information.

## Environment Variables
```
ENV PGHOME=/var/lib/pgsql
ENV PGDATA=${PGHOME}/data
ENV PGPORT=5432
ENV PGSHARE=/usr/share/pgsql
ENV POST_INIT=/usr/share/pgsql-post-init

```

## Volumes
The following volumes can be mounted from the host.

#### /var/lib/pgsql
The PostgreSQL home directory. This includes the data directory.

#### /usr/share/pgsql-post-init
This volume contains scripts (name matching `*.sh`) that need to executed after `initdb` run completes. These scripts are only executed once. The postgres service will be restart once these are completed.

A sample post-init script could be:
```
#!/usr/bin/env bash
# create a user, a database and enable access to it over the network.

DB_USER=user
DB_NAME=userdb
DB_USER_PASS=$(pwgen -c -n -1 14)

psql --command "CREATE USER ${DB_USER} WITH PASSWORD '${DB_USER_PASS}';"
/bin/createdb --owner ${DB_USER} ${DB_NAME} > /dev/null 2>&1

echo "host ${DB_NAME} ${DB_USER} 0.0.0.0/0 md5" >> ${PGDATA}/pg_hba.conf
echo "listen_addresses = '*'" >> ${PGDATA}/postgresql.conf
```

## Ports
**5432**: PostgreSQL port
