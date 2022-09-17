#!/bin/bash +x

containerName="vca-v4"
imageName="dagger:v4"

docker stop $container
if [ $? -eq 0 ];then
    docker rm $container
    if [ $? -eq 0 ];then
        docker rmi $imageName
        if [ $? -eq 0 ];then
            sudo rm /data/containerFile.txt
            sudo rm /data/imageFile.txt
        fi
    fi
fi


