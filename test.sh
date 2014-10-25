#!/bin/bash

#export PARAM1="~/Downloads/3dfjdk-6u26-linux-i586.2bin"
#export PARAM2="~/Downloads/jdk-6u26-linux-i586.bin"

#if [ ! -f "$PARAM1" ]; then
#echo "~/Downloads/jdk-6u26-linux-i586.bin ok!"
#else
#echo "~/Downloads/jdk-6u26-linux-i586.bin not there!"
#fi

cd ~/
sudo mkdir /usr/lib/jvm
sudo mv jdk1.6.0_26 /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_26/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_26/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_26/bin/javaws 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.6.0_26/bin/jar 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/jdk1.6.0_26/bin/javadoc 1
java -version
cd ~/
