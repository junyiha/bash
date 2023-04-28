#! /bin/bash

function StartServer()
{
    export LD_LIBRARY_PATH=/data/dagger/VideoProcess/lib:/data/dagger/VideoProcess/3party/lib:/system/lib:${LD_LIBRARY_PATH}

    export PATH=/data/dagger/VideoProcess:/data/dagger/VideoProcess/bin/:/usr/local/python38/bin/:${PATH}

    export PYTHONPATH=/system/lib:${PYTHONPATH}

    export ABCDK_LOG_CONSIGNEE=192.169.5.31:65535

    # sleep 180

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
    sleep 5

    # check 
    supervisorctl status

    sleep 10000000000000000000000000
}

function TestVCA_2()
{
    ./vca.exe --id 1 --detector-conf-inline --detector-conf @--detector-models@/data/dagger/static/Fire_NVIDIA_A500/DETECT.conf@xxx@yyy --input-video-name  rtsp://192.169.4.16/test_fire_smoke.mp4 --output-type 0
}

function ICE_VCA_TAR()
{
    rm -r VideoProcess
    tar -zvxf VideoProcess-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-devel-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-ice-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-kms-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-vca-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
}

function RK_Docker()
{
    # failed 
    # docker run -itd --name debian -v /usr:/rk_usr debian:10 bash
    # 成功，rkmedia_vi_vo_test 输出的日志和在宿主机中一致
    docker run -itd --name debian --privileged -v /dev/media0:/dev/media0 -v /usr:/rk_usr debian:10 bash
    # 企业微信邮箱回复  apt不能使用，大概是由于/usr/lib覆盖掉了docker里的/usr/lib，apt找不到原本的动态库
    # docker run -it -d --privileged=true -v /userdata/:/userdata/ -v /dev/media0:/dev/media0 -v /dev/galcore:/dev/galcore -v /usr/lib:/usr/lib -v /usr/bin:/rk_usr/bin --device=/dev/galcore --name ubuntu_2 ubuntu:18.04
    # 增加了端口映射
    docker run -it -d --privileged=true -v /userdata/:/userdata/ -v /dev/media0:/dev/media0 -v /dev/galcore:/dev/galcore -v /usr/:/rk_usr --device=/dev/galcore -p 10022:22 -p 10008:10008  --name rk ubuntu18/rk:v1
}

function RK_Test()
{
    # 文件解码测试，仅支持JPEG，H264，H265
    rkmedia_vdec_test -w 1280 -h 720 -i ./highway.mp4  -f 1 -t H264
}

function TestCopy()
{
    tmp_dir="/tmp/nvidia-encode-library"
    if [[ -e ${tmp_dir} ]]; then 
        rm -rf ${tmp_dir}
    fi 

    mkdir ${tmp_dir}
    
    cp /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.* ${tmp_dir} 
    rm "${tmp_dir}/libnvidia-encode.so.1"
    libnvidia_encode=$(ls ${tmp_dir})
    echo ${libnvidia_encode}
    cp /usr/lib/x86_64-linux-gnu/libnvcuvid.so.* ${tmp_dir}
    rm "${tmp_dir}/libnvcuvid.so.1"
    libnvcuvid=$(ls ${tmp_dir} | grep libnvcuvid.so)
    echo ${libnvcuvid}
}

function Install_NVIDIA_Toolkit()
{
    apt install -y curl
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
    apt-get update && apt-get install -y nvidia-container-toolkit
    systemctl restart docker
}

function StartDockerInNVIDIA()
{
    # docker run -itd --gpus all --privileged=true --restart=always --name $1 $2 /bin/bash

    CMD="docker run \
        -itd \
        --name $1 \
        --gpus all \
        --restart=always \
        --privileged=true \
        -p 8083:8083 \
        -p 8084:8084 \
        -p 15379:6379 \
        -p 13306:3306 \
        -p 17007:17007 \
        -p 10022:10022 \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/timezone:/etc/timezone:ro \
        -e LOCAL_USER_ID=`id -u` \
        -e LANG=C.UTF-8 \
        -e LC_ALL=C.UTF-8 \
        $2 \
        /bin/bash /etc/init.d/start_server.sh"
    echo $CMD
    eval $CMD

    tmp_dir="/tmp/nvidia-encode-library"
    if [[ -e ${tmp_dir} ]]; then 
        rm -rf ${tmp_dir}
    fi 

    mkdir ${tmp_dir}
    
    cp /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.* ${tmp_dir} 
    rm "${tmp_dir}/libnvidia-encode.so.1"
    libnvidia_encode=$(ls ${tmp_dir})
    echo ${libnvidia_encode}
    cp /usr/lib/x86_64-linux-gnu/libnvcuvid.so.* ${tmp_dir}
    rm "${tmp_dir}/libnvcuvid.so.1"
    libnvcuvid=$(ls ${tmp_dir} | grep libnvcuvid.so)
    echo ${libnvcuvid}
    
    docker cp /usr/lib/x86_64-linux-gnu/${libnvidia_encode} $1:/usr/lib/x86_64-linux-gnu/
    docker cp /usr/lib/x86_64-linux-gnu/${libnvcuvid} $1:/usr/lib/x86_64-linux-gnu/
    docker exec -it $1 /bin/bash -c "ln -s /usr/lib/x86_64-linux-gnu/${libnvcuvid} /usr/lib/x86_64-linux-gnu/libnvcuvid.so.1"
    docker exec -it $1 /bin/bash -c "ln -s /usr/lib/x86_64-linux-gnu/libnvcuvid.so.1 /usr/lib/x86_64-linux-gnu/libnvcuvid.so"

    docker exec -it $1 /bin/bash -c "ln -s /usr/lib/x86_64-linux-gnu/${libnvidia_encode} /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1"
    docker exec -it $1 /bin/bash -c "ln -s /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1 /usr/lib/x86_64-linux-gnu/libnvidia-encode.so"
}

function TestVCA()
{
    model="/data/dagger/static/models/Fire_BITMAINLAND/DETECT.conf"
    /data/dagger/VideoProcess/bin/vca.exe --id 123 \
        --detector-conf-inline \
        --detector-conf \
        @--detector-models@${model}@xxx@yyy \
        --input-video-name \
        rtsp://192.169.4.16/test_personcount.mp4 \
        --output-type 0 \
        --output-frame-annex
}

# 从指定镜像启动一个容器 
# 第一个参数 ： 容器名称
# 第二个参数 ： 镜像
# 3306 : mysql
# 17007 : kms
function StartDockerVCA
{
    CMD="docker run \
        -itd \
        --name $1 \
        --restart=always \
        --privileged=true \
        -p 8083:8083 \
        -p 8084:8084 \
        -p 15379:6379 \
        -p 13306:3306 \
        -p 17007:17007 \
        -v /system:/system \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/timezone:/etc/timezone:ro \
        -e LOCAL_USER_ID=`id -u` \
        -e PYTHONPATH=/system/lib \
        -e LANG=C.UTF-8 \
        -e LC_ALL=C.UTF-8 \
        $2 \
        /bin/bash /etc/init.d/start_server.sh"

    echo $CMD
    eval $CMD
}

# 删除指定容器和指定镜像
function DeleteDocker()
{
    if [[ -n $1 ]]; then 
        echo "delete $1"
        docker kill $1
        docker rm $1
    fi
    if [[ -n $2 ]]; then 
        echo "delete $2"
        docker rmi $2
    fi
}

function Clear()
{
    echo "clear redundant files..."
    vca_program="/data/dagger/VideoProcess/bin/makelicence.exe"
    log_vca="/tmp/videoprocess.log/s1.log"
    log_ice="/tmp/ice.log"
    log_computing_control="/data/dagger/computing_node/logs/control"
    log_computing_process="/data/dagger/computing_node/logs/process"
    log_supervisor="/data/dagger/logs/supervisor/supervisord_control_err.log"
    log_web_backend="/data/dagger/logs/web_backend/uwsgi.log"
    static_images="/data/dagger/static/platform/images/event"
    static_excel="/data/dagger/static/platform/excel/record_warning"
    system_id="/data/dagger/SystemId"

    if [[ -e ${log_computing_control} ]]; then 
        echo "clearing /data/dagger/computing_node/logs/control/*"
        rm -rf /data/dagger/computing_node/logs/control/*
    fi 

    if [[ -e ${log_computing_process} ]]; then 
        echo "clearing /data/dagger/computing_node/logs/process/*"
        rm -rf /data/dagger/computing_node/logs/process/*
    fi

    if [[ -e ${log_ice} ]]; then 
        echo "clearing /tmp/ice.log"
        rm /tmp/ice.log
    fi

    if [[ -e ${vca_program} ]]; then 
        rm ${vca_program}
    fi

    if [[ -e ${log_vca} ]]; then
        echo "clearing /tmp/videoprocess.log/*"
        rm -rf /tmp/videoprocess.log/*
    fi

    if [[ -e ${log_supervisor} ]]; then
        echo "clearing /data/dagger/logs/supervisor/*"
        rm -rf /data/dagger/logs/supervisor/*
    fi

    if [[ -e ${log_web_backend} ]]; then
        echo "clearing /data/dagger/logs/web_backend/*" 
        rm -rf /data/dagger/logs/web_backend/*
    fi

    if [[ -e ${static_images} ]]; then
        echo  "clearing /data/dagger/static/platform/images/*"
        rm -rf /data/dagger/static/platform/images/*
    fi

    if [[ -e ${static_excel} ]]; then
        echo "clearing /data/dagger/static/platform/excel/*"
        rm -rf /data/dagger/static/platform/excel/*
    fi

    if [[ -e ${system_id} ]]; then 
        echo "clearing ${system_id}"
        rm -rf ${system_id}
    fi
}

function MakeDockerImportImage()
{
    if [[ -z $1 ]]; then 
        echo "Error: empty image name..."
    else 
        tar -cvf $1 --exclude=/sys --exclude=/system --exclude=/proc --exclude=$1 /
    fi
}

function Help()
{
    echo "Usage: ./deploy.sh [-h]"
    echo "shell script for deploy vca project..."
    echo -e 
    echo "  -c, --clear  clear redundant files"
    echo "  -m, --make-docker-image  './deploy.sh -m demo.tar.gz'make docker image which is used in docker import"
    echo "  -s, --start-docker  './deploy.sh -s face zhuoer:face_0322'create container from a docker image"
    echo "  -d, --delete-docker  './deploy.sh -d face zhuoer:face_0322': delete docker container and docker image"
    echo "  --start-docker-in-nvidia  '.deploy.sh --start-docker-in-nvidia name nvidia/vca:v3.0'create a container in nvidia docker"
}

function main()
{
    if [[ $1 == "-c" || $1 == "--clear" ]]; then 
        Clear
    elif [[ $1 == "-m" || $1 == "--make-docker-image" ]]; then 
        MakeDockerImportImage $2
    elif [[ $1 == "-s" || $1 == "--start-docker" ]]; then 
        StartDockerVCA $2 $3 
    elif [[ $1 == "-h" || $1 == "--help" ]]; then 
        Help
    elif [[ $1 == "-d" || $1 == "--delete-docker" ]]; then 
        DeleteDocker $2 $3
    elif [[ $1 == "-vca" || $1 == "--vca-single-task" ]]; then 
        TestVCA
    elif [[ $1 == "--start-docker-in-nvidia" ]]; then 
        StartDockerInNVIDIA $2 $3
    elif [[ $1 == "--test" ]]; then 
        TestCopy
    elif [[ $1 == "--install-nvidia-toolkit" ]]; then 
        Install_NVIDIA_Toolkit
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else
    echo "Too few arguments..."
    echo "Try './deploy.sh -h' for more information..."
fi