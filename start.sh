#! /bin/bash +x

SHELLNAME=$(basename $0)
SHELLDIR=$(cd `dirname $0`; pwd)

cd /data
imageName="image:pure"
containerName="vca-pure"
imagePacket="/data/image-pure.tar"

imageFlag=0
imageFile="/data/image.txt" 
# The image.txt file uses to judge whether loading the docker image successful or not
#    If the file exists and the number which the file saving is 1 , it means that loading the docker image successfully.
#    All of the other case are judged that can not load the docker image .And it will delete the docker image , reload docker iamge and create the imageFile.txt file.

containerFlag=0
containerFile="/data/container.txt"
# The container.txt file uses to judge whether creating the container successful or not.
#    If the file exists and the number which the file saving is 1, it means that creating the container successfully.
#    All of the other case are judged that failed to creating the container. And it will delete the container , recreate the container and create the containerFile.txt file.

function load_image() {
    if [ ! -f "$imageFile" ];then
        sudo docker stop $containerName
        sudo docker rm $containerName
        sudo docker rmi $imageName
        sudo docker load --input $imagePacket
        if [ $? -eq 0 ];then
            echo "load the docke image successfully"
            touch "$imageFile"
            echo 1 | sudo tee $imageFile
        else
            echo "failed to load the docker image"
            sudo docker stop $containerName
            sudo docker rm $containerName
            sudo docker rmi $imageName
            sudo rm $imageFile
            return  4
        fi
    else
        imageFlag=$(cat $imageFile)
        if [ $imageFlag == 1 ];then
            echo "the docker image exists"
        else
            sudo docker stop $containerName
            sudo docker rm $containerName
            sudo docker rmi $imageName
            sudo docker load --input $imagePacket
            if [ $? -eq 0 ];then
                echo "load the docke image successfully"
                echo 1 | sudo tee $imageFile
            else
                echo "failed to load the docker image"
                sudo docker stop $containerName
                sudo docker rm $containerName
                sudo docker rmi $imageName
                echo 0 | sudo tee $imageFile
                return 4
            fi
        fi
    fi
}

function create_container(){
    if [ ! -f "$containerFile" ];then
        sudo docker stop $containerName
        sudo docker rm $containerName
        sudo docker run -itd --name $containerName --restart=always --privileged=true -p 8083:8083 -p 5678:5678 -v /system:/system $imageName  /bin/bash /etc/init.d/start_server.sh 
        if [ $? -eq 0 ];then
            echo "create the container successfully"
            touch $containerFile
            echo 1 | sudo tee $containerFile
            return 1
        else
            echo "failed to create the container"
            sudo docker stop $containerName
            sudo docker rm $containerName
            sudo rm $containerFile
            return 6
        fi
    else
        containerFlag=$(cat $containerFile)
        if [ $containerFlag == 1 ];then
            echo "the container exists"
            return 1
        else
            sudo docker stop $containerName
            sudo docker rm $containerName
            sudo docker run -itd --name $containerName --restart=always --privileged=true -p 8083:8083 -p 5678:5678 -v /system:/system $imageName /bin/bash /etc/init.d/start_server.sh 
            if [ $? -eq 0 ];then
                echo "create the container successfully"
                echo 1 | sudo tee $containerFile
                return 1
            else
                echo "failed to create the container"
                sudo docker stop $containerName
                sudo docker rm $containerName
                echo 0 | sudo tee $containerFile
                return 6
            fi
        fi
    fi
}

for i in {1..5}
do
    systemctl status docker > /dev/null
    if [ $? -eq 0 ];then
        echo "the docker service is running"
        load_image
        if [ $? -eq 4 ];then
            echo "the load_image function is failed"
            continue
        fi

        echo "loading docker image successful , now creating the container"
        create_container
        if [ $? -eq 1 ];then
            echo "creating container successfully"
            break
        fi
    else
        echo "the docker service is not running"
        sleep 7
    fi
done

# run the start.sh twice
if [ $# -eq 0 ];then
flag=1
else
flag=$1
fi

if [ $flag -eq 1 ];then
     sudo ${SHELLDIR}/start.sh  `expr $flag + 1`
fi
