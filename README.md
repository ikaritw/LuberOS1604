# LuberOS1604
Hadoop On Lubuntu1604 with Docker

使用Virtualbox，基於Docker技術，建立Hadoop的開發環境。

ref

- https://hub.docker.com/r/dafu/bigdata/
- http://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/ 

[Lubuntu](http://lubuntu.net/)

VirtualBox環境

1. sudo apt-get update && apt-get upgrade -y
2. sudo apt-get install dkms
3. sudo sh /media/$USER/VBOXADDITIONS_5*/VBoxLinuxAdditions.run

Lubuntu環境(16.04)

1. sudo apt-get install openssh-server vim vim-scripts ctags git openjdk-8-jdk
2. https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
3. sudo dpkg -i sublime-text_build-3126_amd64.deb

Docker環境

1. sudo apt-get install apt-transport-https ca-certificates
2. sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
3. sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
4. sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
5. sudo apt-get update && sudo apt-get install docker-engine -y
6. sudo groupadd docker
7. sudo usermod -aG docker $USER
8. sudo systemctl enable docker

Hadoop環境


