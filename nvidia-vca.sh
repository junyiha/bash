#! /bin/bash +x

function vca_test()
{
    # 使用命令行测试模型
    CMD="/data/dagger/VideoProcess/bin/vca.exe --id 1 --detector-conf-inline \
    --detector-conf @--detector-models@$1@yyyyyyyy@xxxxx@ \
    --input-video-name $2 --output-type 2 --output-video-name $3"
    echo $CMD
    eval $CMD
}

function create_docker()
{
    # 启动docker命令，能够正常检测 但是会重复检测两次，暂时未找到原因
    CMD="docker run -it --gpus all --privileged=true --restart=always --name $1 \
        -v /usr/lib/x86_64-linux-gnu/libnvcuvid.so.470.141.03:/usr/lib/x86_64-linux-gnu/libnvcuvid.so.470.141.03 \
        -v /usr/lib/x86_64-linux-gnu/libnvcuvid.so.1:/usr/lib/x86_64-linux-gnu/libnvcuvid.so.1  \
        -v /usr/lib/x86_64-linux-gnu/libnvcuvid.so:/usr/lib/x86_64-linux-gnu/libnvcuvid.so \
        -v /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.470.141.03:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so.470.141.03 -\
        v /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1  \
        -v /usr/lib/x86_64-linux-gnu/libnvidia-encode.so:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so \
        $2 bash"

    echo $CMD
    eval $CMD
}

# docker run -it --gpus all --privileged=true --restart=always --name cuda-v1 -v /usr/lib/x86_64-linux-gnu/libnvcuvid.so.470.141.03:/usr/lib/x86_64-linux-gnu/libnvcuvid.so.470.141.03 -v /usr/lib/x86_64-linux-gnu/libnvcuvid.so.1:/usr/lib/x86_64-linux-gnu/libnvcuvid.so.1 -v /usr/lib/x86_64-linux-gnu/libnvcuvid.so:/usr/lib/x86_64-linux-gnu/libnvcuvid.so -v /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.470.141.03:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so.470.141.03 -v /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1 -v /usr/lib/x86_64-linux-gnu/libnvidia-encode.so:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so nvidia:vca-v2 bash

# create_docker $1 $2

# vca_test $1 $2 $3 
