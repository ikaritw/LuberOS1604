#!/bin/bash

# root path
LUBER_ROOT=$(pwd)/luber

## JAVA 
JDK_HOME="$LUBER_ROOT/java"
#JDK_URL="http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz"
if [ ! -d $JDK_HOME ]; then
	echo -e "\nCreate $JDK_HOME"
	mkdir -p $JDK_HOME
	curl -L $JDK_URL -H 'Cookie: oraclelicense=accept-securebackup-cookie' | tar --strip-components=1 -xz -C $JDK_HOME
fi
$JDK_HOME/bin/java -version
export JAVA_HOME=$JDK_HOME

## hadoop-2.7.3.tar.gz
HADOOP_HOME="$LUBER_ROOT/hadoop-2.7.3"
HADOOP_URL="http://apache.stu.edu.tw/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz"
if [ ! -d $HADOOP_HOME ]; then
	echo -e "\nCreate $HADOOP_HOME"
	mkdir -p $HADOOP_HOME
	curl -L $HADOOP_URL | tar --strip-components=1 -xz -C $HADOOP_HOME
else
	H=$($HADOOP_HOME/bin/hadoop version|grep "Hadoop")
	if [ "$H" != "" ]; then 
		echo -e "\n$H installed"
	else 
		echo -e "\nNo hadoop found"
	fi
	export HADOOP_HOME=$HADOOP_HOME
fi

## pig-0.16.0
PIG_HOME="$LUBER_ROOT/pig-0.16.0"
PIG_URL="http://ftp.tc.edu.tw/pub/Apache/pig/pig-0.16.0/pig-0.16.0.tar.gz"
if [ ! -d $PIG_HOME ]; then
	echo -e "\nCreate $PIG_HOME"
	mkdir -p $PIG_HOME
	curl -L $PIG_URL | tar --strip-components=1 -xz -C $PIG_HOME
fi

## apache-hive-2.1.0
HIVE_HOME="$LUBER_ROOT/hive-2.1.0"
HIVE_URL="http://ftp.tc.edu.tw/pub/Apache/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz"
if [ ! -d $HIVE_HOME ]; then
	echo -e "\nCreate $HIVE_HOME"
	mkdir -p $HIVE_HOME
	curl -L $HIVE_URL | tar --strip-components=1 -xz -C $HIVE_HOME
fi

# link to /opt/luber
LUBER_ROOT_LINK="/opt/$(echo $LUBER_ROOT|rev|cut -d'/' -f1|rev)"
if [ ! -d $LUBER_ROOT_LINK ]; then
	sudo ln -s $LUBER_ROOT $LUBER_ROOT_LINK
fi

echo -e "\nCreate Hadoop Contaniner\n"

HADOOP_NETWORK_NAME="hadoop"
HADOOP_NETWORK=$(docker network ls|grep "$HADOOP_NETWORK_NAME")
if [ "$HADOOP_NETWORK" == "" ]; then
	echo -e "Create docker network with Name:$HADOOP_NETWORK_NAME"
	docker network create $HADOOP_NETWORK_NAME
else
	echo -e "Docker network Name:$HADOOP_NETWORK_NAME have exists."
fi

HADOOP_IMAGE_NAME="ikaritw/luberos:1.0"
docker run -itd -p 1022:22 --name nn --hostname nn -v $LUBER_ROOT_LINK:/opt/luber --net=hadoop "$HADOOP_IMAGE_NAME"

echo "Complete init"