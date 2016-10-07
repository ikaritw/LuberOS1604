#!/bin/bash

# ssh without key
if [ ! -f ~/.ssh/id_rsa ]; then
	ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ''
	cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
fi

sudo apt-get install dkms
sudo sh /media/$USER/VBOXADDITIONS_5*/VBoxLinuxAdditions.run
sudo apt-get install vim vim-scripts ctags git openjdk-8-jdk

SUBLIME_FILE=sublime-text_build-3126_amd64.deb
if [ ! -f ./${SUBLIME_FILE} ]; then
	wget "https://download.sublimetext.com/${SUBLIME_FILE}"
	sudo dpkg -i ${SUBLIME_FILE}
	rm ${SUBLIME_FILE}
fi

sudo apt-get update && apt-get upgrade -y
sudo apt-get autoremove && sudo apt-get autorclean