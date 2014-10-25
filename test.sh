#!/bin/bash

#export PARAM1="~/Downloads/3dfjdk-6u26-linux-i586.2bin"
#export PARAM2="~/Downloads/jdk-6u26-linux-i586.bin"

#if [ ! -f "$PARAM1" ]; then
#echo "~/Downloads/jdk-6u26-linux-i586.bin ok!"
#else
#echo "~/Downloads/jdk-6u26-linux-i586.bin not there!"
#fi

cd ~/
echo
echo "安装 openjdk-7-jdk!"
echo
sudo apt-get update
sudo apt-get install openjdk-7-jdk
sudo update-alternatives --config java
sudo update-alternatives --config javac
cd ~/
java -version
cd ~/
