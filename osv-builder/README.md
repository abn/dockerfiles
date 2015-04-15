# Docker Build/Developement Environment for OSv

This docker container is intended to be a build/development environment for OSv, OSv Application/Appliances.

OSv is an amazing Operating System by [Cloudius Systems](http://www.cloudius-systems.com/) designed for cloud workloads. Visit http://osv.io/ for more information.

## Building locally

```sh
docker build -t osv-builder
```

## Launching an interactive session

```sh
docker run -it \
  --volume ${HOST_BUILD_DIR}:/osv/builder \
  osv-builder
```

This will place you into the OSv source clone. You can work with it as you normally would.

## The `osv` Command

**Note** that the commands you run can be prefixed with `osv`, the source for which is available at `assets/osv`. For example you can build by:

```sh
docker run \
  --volume ${HOST_BUILD_DIR}:/osv/build \
  osv-builder \
  osv build image=opendaylight
```

Note that the _osv script_, by default provides the following convenience wrappers:

| Command  | Mapping |
| :------------ | :------------ |
| build _args_ | scripts/build |
| run _args_ | scripts/run.py |
| appliance _name_ _components_ _description_ | scripts/build-vm-img |
| clean | make clean |

If any other command is used, it is simply passed on as `scripts/$CMD "$@"` where `$@` is the arguments following the command.

You could also run commands as:

```sh
docker run \
  --volume ${HOST_BUILD_DIR}:/osv/build \
  osv-builder \
  ./scripts/build image=opendaylight
```

## Building an appliance images

If using the pre-built version from docker hub, use `alectolytic/osv-builder` instead of `osv-builder`.

```sh
HOST_BUILD_DIR=$(pwd)/build
docker run \
  --volume ${HOST_BUILD_DIR}:/osv/build \
  osv-builder \
  osv appliance zookeeper apache-zookeeper,cloud-init "Apache Zookeeper on OSv"
```

If everything goes well, the images should be available in `${HOST_BUILD_DIR}`.

## Volume Mapping

| Volume  | Description |
| :------------ | :------------ |
| /osv | This directory contains the OSv repository. |
| /osv/apps | The OSv apps directory. Mount this if you are testing local applications. |
| /osv/build | The OSv build directory containing release and standalone directories. |
| /osv/images | The OSv image build configurations. |
