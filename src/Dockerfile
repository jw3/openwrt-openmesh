FROM centos:7

RUN yum update -y \
 && yum install -y \
        minicom lrzsz file which unzip wget patch git svn make gcc-c++ \
        gawk flex ncurses-devel expect zlib-devel gmp gmp-devel \
        bzip2 zlib-static zlib-devel libssl openssl openssl-devel \
        net-tools perl-Data-Dumper perl-Thread-Queue

RUN git clone https://dev.cloudtrax.com/git/ap51-flash.git ap51-flash \
 && cd ap51-flash \
 && make \
 && cd ..

RUN git clone https://github.com/openwrt/openwrt.git

COPY .config openwrt

RUN cd openwrt \
 && scripts/feeds update -a \
 && scripts/feeds install luci

RUN cd openwrt \
 && make defconfig \
 && grep "^[^#;]" .config | grep -i target \
 && FORCE_UNSAFE_CONFIGURE=1 make
