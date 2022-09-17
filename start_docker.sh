#! /bin/bash +x

TAG="fullscreen"
IMAGE="image"
NAME="vca-fullscreen"

CMD="docker run \
    -itd \
    --name $NAME \
    --restart=always \
    --privileged=true \
    -p 8083:8083 -p 5678:5678 \
    -v /system:/system \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/timezone:/etc/timezone:ro \
    -e PYTHONPATH=/system/lib \
    $IMAGE:$TAG \
    /bin/bash /etc/init.d/start_server.sh"

echo $CMD
eval $CMD