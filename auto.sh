#!/bin/bash
#use like this:  ./auto.sh --auto 2>&1 | tee build.log

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

echo " 安卓开发环境自动配置脚本 "
echo "作者：Ruling."

clear

echo
echo "进行系统更新"
echo
sudo apt-get update

clear


echo "正在配置vim"
echo -e 'set number\nset expandtab\nset tabstop=4' >> ~/.vimrc
echo "完成配置vim!!"

clear

echo
echo "进入下载目录"
echo
if [ ! -d ~/Downloads ]; then
  mkdir -p ~/Downloads
fi
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 Python!"
echo
sudo apt-get install build-essential gcc $PARAM
#if file is there
#wget http://www.python.org/ftp/python/3.3.2/Python-3.3.2.tgz
tar -xvzf Python-3.3.2.tgz
cd ~/Downloads/Python-3.3.2
./configure --prefix=/usr/local/python3.3
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python3.3/bin/python /usr/bin/python3.3
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
  echo "无人值守安装. 按任意键暂停..."
else
  read -p "按回车键继续..."
fi

clear

echo
echo "安装 CCache!"
echo
#if file is there
#wget http://www.samba.org/ftp/ccache/ccache-3.1.9.tar.gz
tar -xvzf ccache-3.1.9.tar.gz
cd ~/Downloads/ccache-3.1.9
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
ccache -M 25G
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 GNU Make!"
echo
#if file is there
#wget http://ftp.gnu.org/gnu/make/make-3.82.tar.gz
tar -xvzf make-3.82.tar.gz
cd ~/Downloads/make-3.82
./configure
sudo make install -j${JOBS}
cd ~/

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 JDK 6!"
echo
#wget  --no-check-certificate --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
cd ~/Downloads
chmod +x jdk-6u45-linux-x64.bin
#cp ~/Downloads/jdk-6u26-linux-i586.bin ~/
#chmod +x jdk-6u26-linux-i586.bin
sudo ./jdk-6u45-linux-x64.bin
sudo mkdir /usr/lib/jvm
sudo mv jdk1.6.0_45 /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_45/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_45/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_45/bin/javaws 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.6.0_45/bin/jar 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/jdk1.6.0_45/bin/javadoc 1
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/jdk1.6.0_45/bin/javap 300
java -version
cd ~/

#echo
#echo "安装 openjdk-7-jdk!"
#echo
#sudo apt-get update
#sudo apt-get install openjdk-7-jdk
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
#cd ~/
#java -version


if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装其他要求资源包!"
echo
sudo apt-get update
sudo apt-get install git gnupg flex bison gperf build-essential \
zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
libgl1-mesa-dev g++-multilib mingw32 tofrodos \
python-markdown libxml2-utils xsltproc zlib1g-dev:i386 \
android-tools-adb android-tools-fastboot libcloog-isl-dev \
texinfo gcc-multilib schedtool libxml2-utils libxml2 \
schedtool optipng pngcrush pngquant vim wine openssh-server screen rar $PARAM

sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo -e "配置ssh"
sudo echo -e 'ServerAliveInterval 15\nTCPKeepAlive yes' >> /etc/ssh/ssh_config
sudo echo -e 'ClientAliveInterval 300\nClientAliveCountMax 100000' >> /etc/ssh/sshd_config
echo -e "配置ssh完成！"
clear



echo -e "配置swap"
sudo echo -e 'vm.swappiness=0' >> /etc/sysctl.conf
echo -e "配置swap完成！"

clear


echo
echo "将终端快捷方式加入右键菜单!"
echo
sudo apt-get install nautilus-open-terminal $PARAM
nautilus -q

echo
echo "安装 GIT!"
echo
sudo apt-get install git $PARAM

echo
echo "安装 Repo"
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
cp -arf ~/auto-build/auto/repo ~/bin/repo
chmod a+x ~/bin/repo
echo "安装 Repo ok!"

#echo
#echo "安装 Hosts"
#echo
#sudo cp -arf hosts /etc/hosts

echo
echo "安装 ADB 驱动!"
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

echo
echo "下载和配置 Android SDK!!"
echo "请确保 unzip 已经安装"
echo
sudo apt-get install unzip $PARAM

if [ `getconf LONG_BIT` = "64" ]
then
echo
#echo "正在下载 Linux 64位 系统的Android SDK"
#        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
#echo "下载完成!!"
cp -rfv ~/Downloads/adt-bundle-linux-x86_64-20140702.zip ~/
echo "sdk zip is there!"
echo "展开文件"
	mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20140702.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
#        mv -f adt-bundle-linux-x86_64-20140702/* .
        mv -f adt-bundle/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
echo "完成!!"
else

echo
echo "正在下载 Linux 32位 系统的Android SDK"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20140702.zip
echo "下载完成!!"
echo "展开文件"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86-20140702.zip ~/adt-bundle/adt_x86.zip
        cd ~/adt-bundle
        unzip adt_x86.zip
        mv -f adt-bundle-linux-x86_64-20140702/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
echo "完成!!"
fi

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 安卓厨房"
echo
cd ~/Downloads
#if file is there
#wget https://github.com/dsixda/Android-Kitchen/archive/master.zip
unzip master.zip
mv -f Android-Kitchen-master ~/Android-Kitchen
echo -e '\n#!/bin/bash\ncd ~/Android-Kitchen\n./menu' >> ~/Android-Kitchen/kitchen
chmod 755 ~/Android-Kitchen/kitchen
ln -s ~/Android-Kitchen/kitchen ~/bin/kitchen
ln -s ~/Android-Kitchen/kitchen ~/Desktop/kitchen

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear


echo -e "安装hosts"
curl https://raw.githubusercontent.com/txthinking/google-hosts/master/hosts > ~/Downloads/hosts
sudo mv /etc/hosts /etc/hosts.bak
sudo cp -f ~/Downloads/hosts /etc/hosts
echo -e "hosts安装完成！"

clear

#echo
#echo "清除临时文件..."
#echo
#rm -f ~/Downloads/Python-3.3.2.tgz
#sudo rm -rf ~/Downloads/Python-3.3.2
#rm -f ~/Downloads/make-3.82.tar.gz
#rm -Rf ~/Downloads/make-3.82
#rm -f ~/jdk-6u45-linux-x64.bin
#rm -f ~/Downloads/ccache-3.1.9.tar.gz
#rm -Rf ~/Downloads/ccache-3.1.9
#rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20140702
#rm -Rf ~/adt-bundle/adt-bundle-linux-x86-20140702
#rm -f ~/adt-bundle/adt_x64.zip
#rm -f ~/adt-bundle/adt_x86.zip
#rm -f ~/Downloads/master.zip

clear

echo
echo "完成!"
echo
echo "感谢使用本脚本!"
echo
read -p "按回车键退出..."
exit
