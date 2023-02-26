#! /bin/bash +x

# 在容器中打包镜像
# 在比特大陆的盒子中，system是容器映射宿主机的目录，因为mia这里面装的是比特大陆定制化的库文件

imageName="$1"
exclude="--exclude=$2"

CMD="tar cvf ${imageName} \
    --exclude=/sys \
    --exclude=/system \
    --exclude=/proc \
    ${exclude} \
    --exclude=/${imageName}  \
    /"
if [ ! -n "$1" ];then
    echo "please input the name of tar file"
else
    echo ${CMD}
    eval ${CMD}
fi
