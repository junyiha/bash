#! /bin/bash +x

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

function StartDockerInNVIDIA()
{
    docker run -itd --gpus all --privileged=true --restart=always --name $1 $2 /bin/bash
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
    log_supervisor="/data/dagger/logs/supervisor/supervisord_control_err.log"
    log_web_backend="/data/dagger/logs/web_backend/uwsgi.log"
    static_images="/data/dagger/static/platform/images/event"
    static_excel="/data/dagger/static/platform/excel/record_warning"

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
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else
    echo "Too few arguments..."
    echo "Try './deploy.sh -h' for more information..."
fi