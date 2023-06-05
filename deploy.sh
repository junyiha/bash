#! /bin/bash

function Decompression()
{
    cd $1
    echo "the workspace is : "
    echo `pwd`
    read -p "going on ? yes[y] | no[n] >>> " opt
    if [[ $opt == "y" || $opt == "yes" ]]; then 
        files=$(ls ./)
        for file in ${files}
        do 
            echo -e
            echo "decompress the file :${file}"
            read -p "going on ? yes[y] | no[n] >>> " option
            if [[ $option == "y" || $option == "yes" ]]; then 
                tar -zxf ${file}
            elif [[ $option == "n" || $option == "no" ]]; then 
                echo "next file..."
                continue 
            else 
                echo "wrong input"
                break
            fi
        done
    elif [[ $opt == "n" || $opt == "no" ]]; then 
        echo "no"
        exit
    else 
        echo "wrong input"
        echo "exit"
        exit
    fi
}

function KillControl()
{
    echo -e
    echo "step 1: supervisorctl stop control..."
    supervisorctl stop control

    echo -e
    echo "step 2: killall -s 9 vca.exe ..."
    killall -s 9 vca.exe 

    echo -e
    echo "step 3: killall -s 9 ice.exe..."
    killall -s 9 ice.exe

    echo -e
    echo "step 4: killall -s 9 python38..."
    killall -s 9 python38
}

function CheckControl()
{

    echo -e
    echo "step 1: ps -eaf | grep ice.exe..."
    ps -eaf | grep ice.exe

    echo -e
    echo "step 2: ps -eaf | grep vca.exe..."
    ps -eaf | grep vca.exe

    echo -e
    echo "step 3: ps -eaf | grep python38..."
    ps -eaf | grep python38
}

function KillManager()
{

    echo -e
    echo "step 1: supervisorctl stop manager ..."
    supervisorctl stop manager 
}

function CheckManager()
{

    echo -e
    echo "step 1: ps -eaf | grep uwsgi..."
    ps -eaf | grep uwsgi

    echo -e 
    echo "step 2: ps -eaf | grep kms.exe..."
    ps -eaf | grep kms.exe...
}

# 清理mysql数据表
function ClearMysql()
{
    sql="mysql -uroot -p123456"
    $sql -e "use ManagerV3;" -e "show tables;"

    echo -e
    echo "step 1: clear table: gh_t_camera_info"
    $sql -e "use ManagerV3;" -e "delete from gh_t_camera_info;"

    echo -e
    echo "step 2: clear table: gh_t_face_db"
    $sql -e "use ManagerV3;" -e "delete from gh_t_face_db;"

    echo -e
    echo "step 3: clear table: gh_t_face_image"
    $sql -e "use ManagerV3;" -e "delete from gh_t_face_image;"

    echo -e
    echo "step 4: clear table: gh_t_face_info"
    $sql -e "use ManagerV3;" -e "delete from gh_t_face_info;"

    echo -e
    echo "step 5: clear table: gh_t_func_conf"
    $sql -e "use ManagerV3;" -e "delete from gh_t_func_conf;"

    echo -e
    echo "step 6: clear table: gh_t_journal"
    $sql -e "use ManagerV3;" -e "delete from gh_t_journal;"

    echo -e
    echo "step 7: clear table: gh_t_record_json"
    $sql -e "use ManagerV3;" -e "delete from gh_t_record_json;"

    echo -e
    echo "step 8: clear table: gh_t_task"
    $sql -e "use ManagerV3;" -e "delete from gh_t_task;"

    echo -e
    echo "step 9: clear table: gh_t_warning_event"
    $sql -e "use ManagerV3;" -e "delete from gh_t_warning_event;"

    echo -e
    echo "step 10: clear table: gh_t_warning_record"
    $sql -e "use ManagerV3;" -e "delete from gh_t_warning_record;"

    echo -e
    echo "step 11: clear table: gh_t_gpu"
    $sql -e "use ManagerV3;" -e "delete from gh_t_gpu;"

    echo -e
    echo "step 12: clear table: gh_t_server"
    $sql -e "use ManagerV3;" -e "delete from gh_t_server;"
}

# 查询数据库各表的数据数量
function CountMysql()
{
    sql="mysql -uroot -p123456"
    $sql -e "use ManagerV3;" -e "show tables;"

    echo -e
    echo "step 1: table: gh_t_algorithm"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_algorithm;"

    echo -e
    echo "step 2: table: gh_t_camera_info"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_camera_info;"

    echo -e
    echo "step 3: table: gh_t_face_db"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_face_db;"

    echo -e
    echo "step 4: table: gh_t_face_image"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_face_image;"

    echo -e
    echo "step 5: table: gh_t_face_info"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_face_info;"

    echo -e
    echo "step 6: table: gh_t_func_conf"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_func_conf;"

    echo -e
    echo "step 7: table: gh_t_journal"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_journal;"

    echo -e
    echo "step 8: table: gh_t_record_json"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_record_json;"

    echo -e
    echo "step 9: table: gh_t_task"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_task;"

    echo -e
    echo "step 10: table: gh_t_warning_event"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_warning_event;"

    echo -e
    echo "step 11: table: gh_t_warning_record"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_warning_record;"

    echo -e
    echo "step 12: table: gh_t_gpu"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_gpu;"

    echo -e
    echo "step 13: table: gh_t_server"
    $sql -e "use ManagerV3;" -e "select count(*) from gh_t_server;"
}

# docker启动mysql,nginx,redis,mqtt,supervisor服务
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

    # sshd
    /etc/init.d/ssh start

    sleep 10000000000000000000000000
}

# 测试vca
function TestVCA_2()
{
    ./vca.exe --id 1 --detector-conf-inline --detector-conf @--detector-models@/data/dagger/static/Fire_NVIDIA_A500/DETECT.conf@xxx@yyy --input-video-name  rtsp://192.169.4.16/test_fire_smoke.mp4 --output-type 0
}

# 解压vca人脸分支的NVIDIA压缩包
function ICE_VCA_TAR_NVIDIA()
{
    rm -r VideoProcess
    tar -zvxf VideoProcess-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-devel-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-ice-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-kms-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
    tar -zvxf VideoProcess-vca-5.1.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz
}

# 解压vca人脸分支的BITMAINLAND压缩包
function ICE_VCA_TAR_BITMAINLAND()
{
    cd /home/user/workspace/video_process/package

    rm -r VideoProcess

    tar -zxvf VideoProcess-5.1.4-ubuntu-18.04-aarch64-BITMAINLAND.tar.gz        
    tar -zxvf VideoProcess-kms-5.1.4-ubuntu-18.04-aarch64-BITMAINLAND.tar.gz
    tar -zxvf VideoProcess-devel-5.1.4-ubuntu-18.04-aarch64-BITMAINLAND.tar.gz  
    tar -zxvf VideoProcess-ice-5.1.4-ubuntu-18.04-aarch64-BITMAINLAND.tar.gz    
    tar -zxvf VideoProcess-vca-5.1.4-ubuntu-18.04-aarch64-BITMAINLAND.tar.gz
    
    cd VideoProcess/3party/lib/
    mv libcrypto.so.1.1 libcrypto.so.1.1.backup
    mv libssl.so.1.1  libssl.so.1.1.backup
}

# RK，英码智能盒子的docker启动命令
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

# RK，英码测试命令
function RK_Test()
{
    # 文件解码测试，仅支持JPEG，H264，H265
    rkmedia_vdec_test -w 1280 -h 720 -i ./highway.mp4  -f 1 -t H264
}

# 拷贝NVIDIA硬件编解码动态库到docker中
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

# 安装NVIDIA 的docker工具组件，用于在docker中使用英伟达的硬件资源（显卡）
function Install_NVIDIA_Toolkit()
{
    apt install -y curl
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
    apt-get update && apt-get install -y nvidia-container-toolkit
    systemctl restart docker
}

# 在NVIDIA硬件平台启动docker
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
        -p 19999:19999 \
        -p 20233:20233 \
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

# 测试VCA命令
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
        -p 19999:19999 \
        -p 20233:20233 \
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

# 清理VCA冗余文件，包括日志文件，敏感文件等
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

# 在容器中，通过tar打包文件，制作镜像，通过docker import导入该镜像文件
function MakeDockerImportImage()
{
    if [[ -z $1 ]]; then 
        echo "Error: empty image name..."
    else 
        tar -cvf $1 --exclude=/sys --exclude=/system --exclude=/proc --exclude=$1 /
    fi
}

# 输出帮助信息
function Help()
{
    echo "Usage: ./deploy.sh [-h]"
    echo "shell script for deploy vca project..."
    echo -e 
    echo "  -h, --help  print help information"
    echo "  -c, --clear  clear redundant files"
    echo "  -m, --make-docker-image  './deploy.sh -m demo.tar.gz'make docker image which is used in docker import"
    echo "  -s, --start-docker  './deploy.sh -s face zhuoer:face_0322'create container from a docker image"
    echo "  -d, --delete-docker  './deploy.sh -d face zhuoer:face_0322': delete docker container and docker image"
    echo "  -kc, --kill-control   kill computing_node process, vca.exe, ice.exe"
    echo "  -cc, --check-control  check the process of computing_node"
    echo "  -km, --kill-manager  kill manager_node process, kms.exe"
    echo "  -cm, --check-manager  check the process of manager_node"
    echo "  -sdin, --start-docker-in-nvidia  '.deploy.sh --start-docker-in-nvidia name nvidia/vca:v3.0'create a container in nvidia docker"
    echo "  -int, --install-nvidia-toolkit  install nvidia toolkit for nvidia driver of encode media"
    echo "  -clm, --clear-mysql  clear ManagerV3 database, delete all tables information"
    echo "  -com, --count-mysql  count tables' data of ManagerV3 database"
    echo "  -tib, --tar-ice-bitmainland  decompression ice file which is on bitmainland"
    echo "  -tin, --tar-ice-nvidia  decompression ice file which is on nvidia"
}

# 主函数，接收和解析输入参数
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
    elif [[ $1 == "sdin" || $1 == "--start-docker-in-nvidia" ]]; then 
        StartDockerInNVIDIA $2 $3
    elif [[ $1 == "--test" ]]; then 
        TestCopy
    elif [[ $1 == "int" || $1 == "--install-nvidia-toolkit" ]]; then 
        Install_NVIDIA_Toolkit
    elif [[ $1 == "-clm" || $1 == "--clear-mysql" ]]; then 
        ClearMysql
    elif [[ $1 == "-com" || $1 == "--count-mysql" ]]; then 
        CountMysql
    elif [[ $1 == "-kc" || $1 == "--kill-control" ]]; then 
        KillControl
    elif [[ $1 == "-cc" || $1 == "--check-control" ]]; then 
        CheckControl
    elif [[ $1 == "-km" || $1 == "--kill-manager" ]]; then 
        KillManager
    elif [[ $1 == "-cm" || $1 == "--check-manager" ]]; then 
        CheckManager
    elif [[ $1 == "-tib" || $1 == "--tar-ice-bitmainland" ]]; then 
        ICE_VCA_TAR_BITMAINLAND
    elif [[ $1 == "-tin" || $1 == "--tar-ice-nvidia" ]]; then 
        ICE_VCA_TAR_NVIDIA
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else
    echo "Too few arguments..."
    echo "Try './deploy.sh -h' for more information..."
fi