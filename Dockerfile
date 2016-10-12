# This dockerfile uses the ubuntu image
# Author: ikaritw
## remeber to set the dns-args of docker service
## ref https://stackoverflow.com/questions/24151129/docker-network-calls-fail-during-image-build-on-corporate-network/38103810#38103810
## check DNS: > nmcli device show | grep IP4.DNS
## add to service: > vim /lib/systemd/system/docker.service
## write to ExecStart
## 
## docker build -t ikaritw/luberos:1.0 .
FROM ubuntu:16.04

MAINTAINER ikaritw <ikaritw+docker@gmail.com>

WORKDIR /root

# Add manager
RUN useradd --create-home --shell /bin/bash biguser \
 && echo 'biguser:biguser' | chpasswd \
 && groupadd bigboss \
 && adduser biguser sudo \
 && adduser biguser bigboss \
 && mkdir -p /home/biguser/hdfs/namenode \
 && mkdir -p /home/biguser/hdfs/datanode \
 && mkdir $HADOOP_HOME/logs

# install openssh-server, openjdk and wget
RUN apt-get update \
 && apt-get install -y curl tar sudo openssh-server openssh-client rsync vim \
 && apt-get autoremove \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/* \
 && ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' \
 && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
 && sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc

# set environment variable
ENV \
 JAVA_HOME=/opt/java/ \
 PATH=$PATH:$JAVA_HOME/bin

CMD [ "sh", "-c", "service ssh start; bash"]

EXPOSE 22
# Hdfs ports 
#EXPOSE 50010 50020 50070 50075 50090 
# Mapred ports 
#EXPOSE 19888 
#Yarn ports 
#EXPOSE 8030 8031 8032 8033 8040 8042 8088 
#Other ports 
#EXPOSE 50070 8088 