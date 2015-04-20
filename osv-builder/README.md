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

This will place you into the OSv source clone. You can work with it as you normally would when working on OSv source, apps, build scripts etc. For example, you can run the following commands, once the above `docker run` commands has been executed, to build and run a tomcat appliance.

```sh
./scripts/build image=tomcat,httpserver
./scripts/run -V
```

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

## Running Capstan

This container also comes with [Capstan](http://osv.io/capstan/) pre-installed. However, to use Capstan, you'll have to run the container with the `--privileged` option set as it requires the KVM kernel module.

### Examples

List the images that we already have on the host by mounting the `~/.capstan/repository` directory. This allows reuse of images across runs of the container.

```sh
docker run \
  --privileged \
  --volume ${HOME}/.capstan/repository:/capstan-repository \
  alectolytic/osv-builder \
  capstan images
```

Capstan build and run `iperf` app:

```
[abn@zoidberg ~]$ sudo docker run -it \
  --privileged \
  alectolytic/osv-builder
bash-4.3# cd apps/iperf
bash-4.3# capstan build
Building iperf...
Downloading cloudius/osv-base/index.yaml...
154 B / 154 B [=================================================================================================================] 100.00 % 0
Downloading cloudius/osv-base/osv-base.qemu.gz...
20.09 MB / 20.09 MB [=======================================================================================================] 100.00 % 1m27s
Uploading files...
1 / 1 [=========================================================================================================================] 100.00 % 0bash-4.3# capstan run
Created instance: iperf
OSv v0.19
eth0: 192.168.122.15
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 64.0 KByte (default)
------------------------------------------------------------
```

## Building appliance images

If using the pre-built version from docker hub, use `alectolytic/osv-builder` instead of `osv-builder`.

```sh
HOST_BUILD_DIR=$(pwd)/build
docker run \
  --volume ${HOST_BUILD_DIR}:/osv/build \
  osv-builder \
  osv appliance zookeeper apache-zookeeper,cloud-init "Apache Zookeeper on OSv"
```

If everything goes well, the images should be available in `${HOST_BUILD_DIR}`. This will contain appliance images for [QEMU/KVM](http://wiki.qemu.org/KVM), [Oracle VirtualBox](https://www.virtualbox.org/), [Google Compute Engine](https://cloud.google.com/compute/) and [VMWare](https://www.vmware.com/) Virtual Machine Disk.

Note that we explicitly disable the build of [VMware ESXi](http://www.vmware.com/products/esxi-and-esx/overview) images since `ovftool` is not available.

For more information regarding OSv Appliances and pre-built ones, refer [here](http://osv.io/virtual-appliances/).

## Volume Mapping

| Volume  | Description |
| :------------ | :------------ |
| /osv | This directory contains the OSv repository. |
| /osv/apps | The OSv apps directory. Mount this if you are testing local applications. |
| /osv/build | The OSv build directory containing release and standalone directories. |
| /osv/images | The OSv image build configurations. |
| /capstan-repository | Capstan repository store. |
