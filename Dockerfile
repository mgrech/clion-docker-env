ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE}

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
	sudo \
	openssh-server openssh-sftp-server rsync \
	make cmake clang gdb \
	libboost-all-dev

RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd \
 && useradd -ms /bin/bash dev \
 && usermod -aG sudo dev \
 && echo 'dev:dev' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
