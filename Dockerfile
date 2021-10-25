FROM       ubuntu:20.04
MAINTAINER Kent Hsieh "https://github.com/kenthsieh/ubuntu-sshd.git"

RUN apt-get update

RUN apt-get install -y openssh-server lrzsz
RUN mkdir /var/run/sshd

RUN echo 'root:passok' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
