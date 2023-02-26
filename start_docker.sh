#! /bin/bash +x

IMAGE="$1"
TAG="$2"
NAME="$3"

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