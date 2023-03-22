#! /bin/bash +x

function StartDockerVCA
{
    NAME="$1"
    IMAGE="$2"
    TAG="$3"

    CMD="docker run \
        -itd \
        --name $NAME \
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
        $IMAGE:$TAG \
        /bin/bash /etc/init.d/start_server.sh"

    echo $CMD
    eval $CMD
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
        tar -zcvf $1 --exclude=/sys --exclude=/system --exclude=/proc --exclude=$1 /
    fi
}

function Help()
{
    echo "Usage: ./deploy.sh [-h]"
    echo "shell script for deploy vca project..."
    echo -e 
    echo "  -c, --clear  clear redundant files"
    echo "  -m, --make-docker-image  make docker image which is used in docker import"
    echo "  -s, --start-docker  create container from a docker image"
}

function main()
{
    if [[ $1 == "-c" || $1 == "--clear" ]]; then 
        Clear
    elif [[ $1 == "-m" || $1 == "--make-docker-image" ]]; then 
        MakeDockerImportImage $2
    elif [[ $1 == "-s" || $1 == "--start-docker" ]]; then 
        StartDockerVCA $2 $3 $4
    elif [[ $1 == "-h" || $1 == "--help" ]]; then 
        Help
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else
    echo "Too few arguments..."
    echo "Try './deploy.sh -h' for more information..."
fi