FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

# configure osv vars
ENV OSV_REPO=https://github.com/cloudius-systems/osv.git
ENV OSV_VERSION=0.19
ENV OSV_DIR=/osv

# install vbox repo
ENV VBOX_REPO=http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
RUN curl -o /etc/yum.repos.d/$(basename ${VBOX_REPO}) ${VBOX_REPO}

# install CloudRouter repo
RUN yum -y install \
    https://repo.cloudrouter.org/1/x86_64/cloudrouter-repo-latest.noarch.rpm

# do an update for sanity
RUN yum -y update

# instal build dependencies
RUN yum -y install \
    git wget zip unzip tar

# install VirtualBox
RUN yum -y install \
    VirtualBox-4.3

# install Capstan
ENV CAPSTAN_ROOT=/capstan-repository
RUN yum -y install \
    capstan

# fetch and setup OSV_REPO branch for OSV_VERSION
RUN git clone -b v${OSV_VERSION} --single-branch ${OSV_REPO} ${OSV_DIR}
RUN cd ${OSV_DIR} && git submodule update --init --recursive

# setup system
RUN cd ${OSV_DIR} && ./scripts/setup.py

# clean up
RUN yum -y clean all

# add assets
ADD ./assets/osv /usr/bin/osv
ADD ./assets/patches ${OSV_DIR}/patches

WORKDIR ${OSV_DIR}

# apply patches
RUN find ${OSV_DIR}/patches -maxdepth 1 -type f -name "*.patch" \
    -exec bash -c "patch -p1 < {}" \;

VOLUME ["/osv", "/osv/build/", "/osv/apps/", "/osv/images/", "/capstan-repository"]

CMD ["/usr/bin/bash"]
