# Dockerfile: PostgreSQL Assets

This directory contains any assets used by the dockerfile.

### pgsql-server-start
This script initializes the database on first boot (if `${PGDATA}` does not exist) and starts the PostgreSQL server in the foreground.

### pgsql-post-init
This directory contains all scripts that executed once `initdb` completes. Any scripts added here during build time will be over-written by runtime volume mounts.

See associated [README](https://github.com/abn/dockerfiles/blob/master/fedora-postgres/assets/pgsql-post-init/README.md) for more information.

### supervisor.conf
This configuration file is used to replace `/etc/supervisor.conf` in the container.

It defines general `supervisord` configuration. Additionally, extra environment variables used by the `pgsql-server-start` script and server execution specifics are configured via this file.
