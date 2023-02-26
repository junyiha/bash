#! /bin/bash +x

export LD_LIBRARY_PATH=/data/dagger/VideoProcess/lib:/data/dagger/VideoProcess/3party/libzmq/lib:/data/dagger/VideoProcess/3party/libuuid/lib:/data/dagger/VideoProcess/3party/libhiredis/lib:/data/dagger/VideoProcess/3party/abcdk-1.3.8/lib:/data/dagger/VideoProcess/3party/libjsoncpp/lib:/data/dagger/VideoProcess/3party/abcdk/lib:/data/dagger/VideoProcess/3party/lapacke/lib:/system/lib:${LD_LIBRARY_PATH}
export PATH=/data/dagger/VideoProcess:/data/dagger/VideoProcess/bin/:${PATH}

export PYTHONPATH=/system/lib:${PYTHONPATH}

# mysql
/etc/init.d/mysql start
sleep 5

# nginx
/etc/init.d/nginx start
sleep 5

# redis
/etc/init.d/redis-server start
sleep 5

# mqtt
/etc/init.d/mosquitto start
sleep 5

# supervisor
/etc/init.d/supervisor stop
sleep 5

/etc/init.d/supervisor start
sleep 5

supervisorctl start all 

# check 
supervisorctl status

sleep 1000000000000000000000