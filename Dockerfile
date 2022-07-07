FROM --platform=linux/amd64 ubuntu:20.04 as builder


RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip liblzo2-dev git
RUN git clone https://github.com/nati0n/jefferson.git
WORKDIR /jefferson
RUN python3 -m pip install -r requirements.txt
RUN python3 -m pip install -U nuitka
RUN python3 setup.py install
RUN python3 -m nuitka /usr/local/bin/jefferson



ADD ./example_file_system.jffs2 ./example_file_system.jffs2
# WORKDIR /fzf
# RUN make
# RUN make install

#FROM ubuntu:20.04 as package

#COPY --from=builder /jefferson/jefferson.bin /jefferson
#COPY --from=builder /jefferson/example_file_system.jffs2 /example_file_system.jffs2

# Technically build and 'package'
# build step with required supporting packages
# package step new docker with binaryldd
# go make gcc cmake clang curl