#! /bin/bash +x

# SHELLNAME=$(basename $0)
# SHELLDIR=$(cd `dirname $0`; pwd)

cd /data/


# basic packets    there are two packets can not be installed : librdkafka-dev libeigen3-dev ( now  it can)


#  libssl-dev openssl libffi-dev zlib1g-dev
# begin
cd /data/python-depend

sudo dpkg -i gcc-6-base-00.deb
dpkg -V gcc-6-base
if [ $? -eq 0 ];then
    echo "gcc-6-base is installed"
else
    sudo apt-get autoremove gcc-6-base
    sudo dpkg -i purge gcc-6-base
    sudo dpkg -i gcc-6-base-00.deb
fi

sudo dpkg -i libgcc1-01.deb
dpkg -V libgcc1
if [ $? -eq 0 ];then
    echo "libgcc1 is installed"
else
    sudo apt-get autoremove libgcc1
    sudo dpkg -i purge libgcc1
    sudo dpkg -i libgcc1-01.deb
fi

sudo dpkg -i libc6-02.deb
dpkg -V libc6
if [ $? -eq 0 ];then
    echo "libc6 is installed"
else
    sudo apt-get autoremove libc6
    sudo dpkg -i purge libc6
    sudo dpkg -i libc6-02.deb
fi

sudo dpkg -i openssl-03.deb
dpkg -V openssl
if [ $? -eq 0 ];then
    echo "openssl is installed"
else
    sudo apt-get autoremove openssl
    sudo dpkg -i purge openssl
    sudo dpkg -i openssl-03.deb
fi

sudo dpkg -i perl-base-04.deb
dpkg -V perl-base
if [ $? -eq 0 ];then
    echo "perl-base is installed"
else
    sudo apt-get autoremove perl-base
    sudo dpkg -i purge perl-base
    sudo dpkg -i perl-base-04.deb
fi

sudo dpkg -i debconf-05.deb
dpkg -V debconf
if [ $? -eq 0 ];then
    echo "debconf is installed"
else
    sudo apt-get autoremove debconf
    sudo dpkg -i purge debconf
    sudo dpkg -i debconf-05.deb
fi

sudo dpkg -i libssl1.1-06.deb
dpkg -V libssl1.1
if [ $? -eq 0 ];then
    echo "libssl1.1 is installed"
else
    sudo apt-get autoremove libssl1.1
    sudo dpkg -i purge libssl1.1
    sudo dpkg -i libssl1.1-06.deb
fi

sudo dpkg -i libssl-dev-07.deb
dpkg -V libssl-dev
if [ $? -eq 0 ];then
    echo "libssl-dev is installed"
else
    sudo apt-get autoremove libssl-dev
    sudo dpkg -i purge libssl-dev
    sudo dpkg -i libssl-dev-07.deb
fi

sudo dpkg -i libffi6-08.deb
dpkg -V libffi6
if [ $? -eq 0 ];then
    echo "libffi6 is installed"
else
    sudo apt-get autoremove libffi6
    sudo dpkg -i purge libffi6
    sudo dpkg -i libffi6-08.deb
fi

sudo dpkg -i libffi-dev-09.deb
dpkg -V libffi-dev
if [ $? -eq 0 ];then
    echo "libffi-dev is installed"
else
    sudo apt-get autoremove libffi-dev
    sudo dpkg -i purge libffi-dev
    sudo dpkg -i libffi-dev-09.deb
fi

sudo dpkg -i libc-dev-bin-10.deb
dpkg -V libc-dev-bin
if [ $? -eq 0 ];then
    echo "libc-dev-bin is installed"
else
    sudo apt-get autoremove libc-dev-bin
    sudo dpkg -i purge libc-dev-bin
    sudo dpkg -i libc-dev-bin-10.deb
fi

sudo dpkg -i linux-libc-dev-11.deb
dpkg -V linux-libc-dev
if [ $? -eq 0 ];then
    echo "linux-libc-dev is installed"
else
    sudo apt-get autoremove linux-libc-dev
    sudo dpkg -i purge linux-libc-dev
    sudo dpkg -i linux-libc-dev-11.deb
fi

sudo dpkg -i libc6-dev-12.deb
dpkg -V libc6-dev
if [ $? -eq 0 ];then
    echo "libc6-dev is installed"
else
    sudo apt-get autoremove libc6-dev
    sudo dpkg -i purge libc6-dev
    sudo dpkg -i libc6-dev-12.deb
fi

sudo dpkg -i zlib1g-13.deb
dpkg -V zlib1g
if [ $? -eq 0 ];then
    echo "zlib1g is installed"
else
    sudo apt-get autoremove zlib1g
    sudo dpkg -i purge zlib1g
    sudo dpkg -i zlib1g-13.deb
fi

sudo dpkg -i zlib1g-dev-14.deb
dpkg -V zlib1g-dev
if [ $? -eq 0 ];then
    echo "zlib1g-dev is installed"
else
    sudo apt-get autoremove zlib1g-dev
    sudo dpkg -i purge zlib1g-dev
    sudo dpkg -i zlib1g-dev-14.deb
fi

#   end

dpkg -V make gcc g++ pkg-config libgomp1 libzmq3-dev libjsoncpp-dev libhiredis-dev libsdl2-dev liblapacke-dev libatlas-base-dev uuid-dev zlib1g-dev librdkafka-dev libeigen3-dev
if [ $? -eq 0 ];then
    echo "the basic packets are installed"
else
    cd /data/basic-packets
    for i in {1..2}
    do
        for i in g++_4%3a6.3.0-4_arm64.deb gcc_4%3a6.3.0-4_arm64.deb libatlas-base-dev_3.10.3-1+b1_arm64.deb libgomp1_6.3.0-18+deb9u1_arm64.deb libhiredis-dev_0.13.3-2_arm64.deb libjsoncpp-dev_1.7.4-3_arm64.deb liblapacke-dev_3.7.0-2_arm64.deb libsdl2-dev_2.0.5+dfsg1-2_arm64.deb libzmq3-dev_4.2.1-4+deb9u2_arm64.deb make_4.1-9.1_arm64.deb pkg-config_0.29-4+b1_arm64.deb uuid-dev_2.29.2-1.1_arm64.deb zlib1g-dev_1%3a1.2.8.dfsg-5_arm64.deb librdkafka-dev_0.9.3-1_arm64.deb libeigen3-dev_3.3.2-1_all.deb;
        do  
            dpkg -i $i
        done
    done

    # if it can connect the network ,the comman will be excute
    sudo apt-get --fix-broken install
fi
cd /data/

# # install python-deb
# cd /data/python-deb
# for i in {1..2}
# do
#     deb01="openssl_1.1.0l-1~deb9u1_arm64.deb zlib1g-dev_1%3a1.2.8.dfsg-5_arm64.deb libffi-dev_3.2.1-6_arm64.deb libssl-dev_1.1.0l-1~deb9u1_arm64.deb"
#     sudo dpkg -i $deb01
    
#     deb02="gnu-smalltalk_3.2.5-1+b3_arm64.deb gnu-smalltalk-common_3.2.5-1_all.deb libffi-dev_3.2.1-6_arm64.deb libgst7_3.2.5-1+b3_arm64.deb libssl-dev_1.1.0l-1~deb9u1_arm64.deb libssl-doc_1.1.0l-1~deb9u1_all.deb zip_3.0-11+b1_arm64.deb zlib1g-dbg_1%3a1.2.8.dfsg-5_arm64.deb zlib1g-dev_1%3a1.2.8.dfsg-5_arm64.deb zlibc_0.9k-4.3_arm64.deb zlib-gst_3.2.5-1+b3_arm64.deb"
#     sudo dpkg -i $deb02

# done

# python
/usr/local/python38/bin/python3.8 -V
if [ $? -eq 0 ];then
    echo "the python38 is installed"
    if [ -f "/usr/bin/python38" ];then
        echo "there is python38 in /usr/bin"
    else
        sudo ln -s /usr/local/python38/bin/python3.8 /usr/bin/python38
    fi
    export PYTHONPATH=${PYTHONPATH}:/system/lib
    source /home/linaro/.bashrc
else
    cd /data/python38
    ./configure --prefix=/usr/local/python38
    make && make install

    sudo ln -s /usr/local/python38/bin/pip3.8 /usr/bin/pip38
    export PYTHONPATH=${PYTHONPATH}:/system/lib
    source ~/.bashrc
fi


# python-pip   the if is not useful 
# /usr/bin/python38 -m pip show APScheduler asgiref backports.zoneinfo certifi chardet configobj Django django-cors-headers django-filter django-redis djangorestframework idna netifaces numpy paho-mqtt Pillow psutil PyMySQL pytz pytz-deprecation-shim pyzmq redis requests six sqlparse tzdata tzlocal urllib3 websockets xlwt
# if [ $? -eq 0 ];then
    # echo "all the pip packets are installed"
# else
cd /data/pip
for i in {1..2}
do
    for x in  asgiref-3.5.2-py3-none-any.whl certifi-2022.6.15-py3-none-any.whl chardet-3.0.4-py2.py3-none-any.whl pytz-2022.1-py2.py3-none-any.whl Django-3.2.5-py3-none-any.whl django_cors_headers-3.11.0-py3-none-any.whl django_filter-21.1-py3-none-any.whl Django-3.2.5-py3-none-any.whl   django_redis-5.2.0-py3-none-any.whl djangorestframework-3.11.0-py3-none-any.whl idna-2.8-py2.py3-none-any.whl PyMySQL-1.0.2-py3-none-any.whl   redis-3.2.1-py2.py3-none-any.whl requests-2.22.0-py2.py3-none-any.whl setuptools-63.4.2-py3-none-any.whl six-1.16.0-py2.py3-none-any.whl sqlparse-0.4.2-py3-none-any.whl tzdata-2022.1-py2.py3-none-any.whl  urllib3-1.25.11-py2.py3-none-any.whl xlwt-1.3.0-py2.py3-none-any.whl pytz_deprecation_shim-0.1.0.post0-py2.py3-none-any.whl tzlocal-4.2-py3-none-any.whl APScheduler-3.8.1-py2.py3-none-any.whl;
    do  
        sudo /usr/bin/python38 -m pip install --no-index $x
    done

    # backports-zoneinfo
    cd /data/pip/backports.zoneinfo-0.2.1
    sudo /usr/bin/python38 setup.py install

    # APScheduler
    cd /data/pip/APS-install

    pytzFirst="pytz_deprecation_shim-0.1.0.post0-py2.py3-none-any.whl"
    tzlocalSecond="tzlocal-4.2-py3-none-any.whl"
    APSchedulerThird="APScheduler-3.8.1-py2.py3-none-any.whl"

    sudo /usr/bin/python38 -m pip install --no-index $pytzFirst
    sudo /usr/bin/python38 -m pip install --no-index $tzlocalSecond
    sudo /usr/bin/python38 -m pip install --no-index $APSchedulerThird

    cd /data/pip

    # pyzmq  因为安装时间太久，所以做if判断，如果安装之后，不必再次安装
    /usr/bin/python38 -m pip show pyzmq
    if [ $? -eq 0 ];then
        echo "the pyzmq is installed"
    else
        cd /data/pip/pyzmq-20.0.0
        sudo /usr/bin/python38 -m pip install .
    fi

    cd /data/pip
done

for i in {1..2}
do
    cd /data/pip/tar
    for y in backports.zoneinfo-0.2.1 configobj-5.0.6 netifaces-0.11.0 paho-mqtt-1.6.1 Pillow-9.0.1 psutil-5.7.0 pyzmq-20.0.0 websockets-10.2 numpy-1.17.2;
    do
        cd $y
        /usr/bin/python38 setup.py install
        cd /data/pip/tar
    done
    cd /data/pip

    # numpy 因为安装时间太久，所以做if判断，如果安装之后，不必再次安装
    cd /data/pip/tar
    /usr/bin/python38 -m pip show numpy
    if [ $? -eq 0 ];then
        echo "the numpy is installed"
    else
        cd /data/pip/tar/numpy-1.17.2
        /usr/bin/python38 setup.py install
        cd /data/pip/tar
    fi
    cd /data/pip
done
# fi
cd /data

# dagger folder
folderName="/data/dagger"
userName=`users`
if [ -d "$folderName" ];then
    echo "the program folder exists"
else
    tarName="/data/dagger.tgz"
    tarPath="/data/"
    if [ -f "$tarName" ];then
        sudo tar -xvf $tarName -C $tarPath
        sudo chown $userName:$userName /data/dagger/* -R
    fi
fi


# redis-server
sudo /etc/init.d/redis-server start
if [ $? -eq 0 ];then
    echo "the redis-server is running"
else
    cd /data/redis
    while [ 0 -eq 0 ]
    do
        cd /data/redis
        sudo /etc/init.d/redis-server start
        if [ $? -eq 0 ];then 
            echo "the redis server is running"
            break;
        fi

        packname01="redis-server_3%3a3.2.6-3+deb9u3_arm64.deb"
        packname02="redis-tools_3%3a3.2.6-3+deb9u3_arm64.deb"
        packname03="libjemalloc1_3.6.0-9.1_arm64.deb"

        sudo dpkg -i $packname01 $packname02 $packname03
    done
fi
cd /data/


# mysql
sudo /etc/init.d/mysql start
if [ $? -eq 0 ];then 
    echo "the mysql server is running "
else
    cd /data/mysql
    while [ 0 -eq 0 ]
    do
        sudo /etc/init.d/mysql start
        if [ $? -eq 0 ];then
            echo "start success"
            sudo mysqladmin -uroot password 123456
            echo "mysql user : root  |  mysql password : 123456"
            break;
        fi
        mysqlName="default-mysql-server_1.0.2_all.deb  galera-3_25.3.19-2_arm64.deb  gawk_1%3a4.1.4+dfsg-1_arm64.deb  libaio1_0.3.110-3_arm64.deb  libcgi-fast-perl_1%3a2.12-1_all.deb  libcgi-pm-perl_4.35-1_all.deb  libconfig-inifiles-perl_2.94-1_all.deb  libdbd-mysql-perl_4.041-2_arm64.deb  libdbi-perl_1.636-1+b1_arm64.deb  libencode-locale-perl_1.05-1_all.deb  libfcgi-perl_0.78-2_arm64.deb  libhtml-parser-perl_3.72-3_arm64.deb  libhtml-tagset-perl_3.20-3_all.deb  libhtml-template-perl_2.95-2_all.deb  libhttp-date-perl_6.02-1_all.deb  libhttp-message-perl_6.11-1_all.deb  libio-html-perl_1.001-1_all.deb  liblwp-mediatypes-perl_6.02-1_all.deb  libreadline5_5.2+dfsg-3+b1_arm64.deb  libsigsegv2_2.10-5_arm64.deb  libterm-readkey-perl_2.37-1_arm64.deb  libtimedate-perl_2.3000-2+deb9u1_all.deb  liburi-perl_1.71-1_all.deb  mariadb-client-10.1_10.1.45-0+deb9u1_arm64.deb  mariadb-client-core-10.1_10.1.45-0+deb9u1_arm64.deb  mariadb-common_10.1.45-0+deb9u1_all.deb  mariadb-server-10.1_10.1.45-0+deb9u1_arm64.deb  mariadb-server-core-10.1_10.1.45-0+deb9u1_arm64.deb  mysql-server_5.5.9999+default_arm64.deb  libjemalloc1_3.6.0-9.1_arm64.deb socat_1.7.3.1-2+deb9u1_arm64.deb"

        sudo dpkg -i $mysqlName
    done
fi
cd /data/


# nginx
sudo /etc/init.d/nginx start
if [ $? -eq 0 ];then 
    echo "the nginx server is running"
else
    cd /data/nginx
    while [ 0 -eq 0 ]
    do
        sudo /etc/init.d/nginx start
        if [ $? -eq 0 ];then
            echo "nginx start success"
            sudo cp /data/dagger/conf.d/nginx/* /etc/nginx/conf.d/
            break;
        fi
        nginxName="geoip-database_20170512-1_all.deb libgd3_2.2.4-2+deb9u5_arm64.deb libgeoip1_1.6.9-4_arm64.deb libjbig0_2.1-3.1+b2_arm64.deb libnginx-mod-http-auth-pam_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-dav-ext_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-echo_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-geoip_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-image-filter_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-subs-filter_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-upstream-fair_1.10.3-1+deb9u4_arm64.deb libnginx-mod-http-xslt-filter_1.10.3-1+deb9u4_arm64.deb libnginx-mod-mail_1.10.3-1+deb9u4_arm64.deb libnginx-mod-stream_1.10.3-1+deb9u4_arm64.deb libtiff5_4.0.8-2+deb9u5_arm64.deb libxpm4_1%3a3.5.12-1_arm64.deb libxslt1.1_1.1.29-2.1+deb9u2_arm64.deb nginx_1.10.3-1+deb9u4_all.deb nginx-common_1.10.3-1+deb9u4_all.deb nginx-full_1.10.3-1+deb9u4_arm64.deb"

        sudo dpkg -i $nginxName
    done
fi
cd /data/


# mqtt
sudo /etc/init.d/mosquitto start
if [ $? -eq 0 ];then
    echo "the mqtt server is running"
else
    cd /data/mqtt
    while [ 0 -eq 0 ]
    do 
        sudo /etc/init.d/mosquitto start
        if [ $? -eq 0 ];then
            echo "mqtt start success"
            break;
        fi
        mqttName="libev4_1%3a4.22-1+b1_arm64.deb libuv1_1.9.1-3_arm64.deb   libwebsockets8_2.0.3-2_arm64.deb mosquitto_1.4.10-3+deb9u4_arm64.deb"
        mqttclientName="libc-ares2_1.12.0-1+deb9u1_arm64.deb libmosquitto1_1.4.10-3+deb9u4_arm64.deb mosquitto-clients_1.4.10-3+deb9u4_arm64.deb"

        sudo dpkg -i $mqttName
        sudo dpkg -i $mqttclientName
        sudo mosquitto -c /usr/etc/mosquitto/mosquitto.conf
    done
fi
cd /data/


# supervisor
sudo /etc/init.d/supervisor start
if [ $? -eq 0 ];then 
    echo "the supervisor server is running "
else
    cd /data/supervisor
    while [ 0 -eq 0 ]
    do 
        sudo /etc/init.d/supervisor start
        if [ $? -eq 0 ];then
            echo "supervisor start success"
            source  /etc/profile
            break;
        fi
        supervisorName="python-meld3_1.0.2-2_all.deb python-pkg-resources_33.1.1-1_all.deb supervisor_3.3.1-1+deb9u1_all.deb"

        sudo dpkg -i $supervisorName
        sudo cp /data/dagger/conf.d/supervisor/* /etc/supervisor/conf.d/
        sudo supervisord -c /etc/supervisor/supervisord.conf
        source  /etc/profile
    done
fi
cd /data/


# VideoProcess
sudo bash /data/dagger/VideoProcess/script/happy-launch.sh /data/dagger/VideoProcess/    vca
source  /etc/profile
sudo /data/dagger/VideoProcess/bin/showdevice.exe --fmt 2 --out /data/dagger/computing_node/etc/

source  /etc/profile
sudo /etc/init.d/supervisor restart


# # checking
# if [ $# -eq 0 ];then
# flag=1
# else
# flag = $1
# fi

# if [ $flag -eq 1 ];then
#      sudo ${SHELLDIR}/install.sh  `expr $flag + 1`
# fi
