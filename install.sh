#!/bin/bash

source "conf.sh";

PROGRAM_PREFIX="";

# If the installation directory is not in PATH issue a warning:
if ! echo $PATH | grep -q "$DIR";
then
    echo "Warning: '$DIR' is not in your PATH.";
    echo "         To use this program add '$DIR'";
    echo "         to your PATH or manually copy";
    echo "         katoolin3.py somewhere.";
    echo;
    PROGRAM_PREFIX="$DIR/";
fi

# Check if shebang from katoolin3.py can execute:
/usr/bin/env python3 -V >/dev/null || die "Please install 'python3'";
apt-get install apt-transport-https ca-certificates
#下载新的密钥
wget -q -O - https://archive.kali.org/archive-key.asc
apt-key add ./archive-key.asc| apt-key net-update
# Install all dependencies:
apt-key adv -qq --keyserver pool.sks-keyservers.net --recv-keys ED444FF07D8D0BF6 || apt-key adv -qq --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys ED444FF07D8D0BF6 || die "This may be a server issue. Please try again later";
apt-get -qq -y -m install python3-apt || die;
#gpg: 从公钥服务器接收失败:服务器故障;以前使用的密钥ED444FF07D8D0BF6过期，在常用密钥服务器上不再存在。新的密钥可以直接从wget https://archive.kali.org/archive-key.asc获取
install -T -g root -o root -m 555 ./katoolin3.py "$DIR/$PROGRAM" || die;

echo "Successfully installed."
echo "Run it with 'sudo $PROGRAM_PREFIX$PROGRAM'.";
exit 0;
