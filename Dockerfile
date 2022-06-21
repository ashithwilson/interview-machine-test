FROM ubuntu:21.10

RUN apt update
RUN apt-get install  openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu 
RUN  echo 'ubuntu:cldr@999' | chpasswd

COPY ./bin/docker/configure.sh /configure.sh
RUN chmod +x /configure.sh
RUN /configure.sh

COPY ./bin/docker/view-session.sh /view-session.sh
RUN chmod +x /view-session.sh

RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
