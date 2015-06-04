# Dockerfile: RPM Builder (CentOS)

A CentOS based RPM Build Environment.

```
docker pull alectolytic/rpmbuilder-centos
```

## Build and Run
### Build
```
docker build --tag alectolytic/rpmbuilder-centos .
```

### Run
In this example `SOURCE_DIR` contains spec file and sources for the the RPM we are building.

```
# set env variables for conviniece
SOURCE_DIR=$(pwd)/sources
TARGET_DIR=$(pwd)/target

# create a target directory
mkdir -p ${TARGET_DIR}

# make SELinux happy
chcon -Rt svirt_sandbox_file_t ${TARGET_DIR} ${SOURCE_DIR}

# build rpm
docker run \
    -v ${SOURCE_DIR}:/sources \
    -v ${TARGET_DIR}:/target \
    alectolytic/rpmbuilder-centos
```

The output files will be available in `TARGET_DIR`.

## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /sources | Source to build RPM from |
| /target | Target directory where all built RPMs and SRPMs are extracted to |
| /workspace | Temporary workspace created for staging sources |
| /root/rpmbuild | rpmbuild directory for debugging etc |
