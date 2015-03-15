# PostgreSQL post-initdb scripts

Scripts in this directory are added to the container and executed when creating the data dir via `initdb`.

### Naming scheme
All scripts in this directory, if required to be executed, should be named to match the `*.sh` pattern.

**NOTE:** These scripts are expected to be executable and readable by the postgres user.
