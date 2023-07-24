#! /bin/bash -x

# 获取指定后缀名文件并解压
function UnCompressFile()
{
    file_arr=($(find . -name "*.tar.gz"))

    for file in "${file_arr[@]}"; 
    do 
        echo ${file}
        tar -zxf ${file}
    done
}

function Record()
{
    while true
    do 
        # gh_2023-07-19_10-25-53.mp4
        current_time=$(date +"%Y-%m-%d_%H-%M-%S") 
        output_file="gh_${current_time}.mp4"
        echo ${output_file}
        # ffmpeg -rtsp_transport tcp -i rtsp://admin:HuaWei123@192.168.1.4/LiveMedia/chi/Media1 -t 12:00:00 -c:v copy -an "${output_file}"
        sleep 5
    done
}

function GitHub()
{
    # config name and email
    git config --global user.name "elliot53"
    git config --global user.email "1604244855@qq.com"

    # check
    echo "user.name: "
    git config user.name
    echo "user.email: "
    git config user.email

    ssh-keygen -t rsa -C "1604244855@qq.com"
}

# 模拟rtsp流
function StartFFServer()
{
    cd /home/user/Videos/
    nohup ffserver -f ffserver.conf &
}

# 护眼软件，降低电脑亮度
function StartRedshift()
{
    nohup redshift &
}

# 以root用户打开VSCode
function VsCode()
{
    alias code='/usr/share/code/code . --no-sandbox --unity-lanuch'
}

# 查看内存信息
# 条件判断，不能使用> < ，需要使用-lt -gt
function WatchMemory()
{
    count=0
    flag=9
    while [ 1 ]
    do
        if [[ ${count} -gt ${flag} ]]; then
            echo "break..." 
            break
        fi
        date 
        free -h 
        echo -e
        let count=${count}+3
        sleep 3
    done
}

function Help()
{
    echo "Usage: ./tools.sh [-h]"
    echo "demo script for daemon running..."
    echo -e
    echo "  -h, --help"
    echo "  -r, --redshift  running redshift to protect eyes..."
    echo "  -w, --watch-memory  watch the memory information"
}

function main()
{
    if [[ $1 == "-r" || $1 == "--redshift" ]]; then 
        StartRedshift
    elif [[ $1 == "-h" || $1 == "--help" ]]; then 
        Help
    elif [[ $1 == "-w" || $1 == "--watch-memory" ]]; then 
        WatchMemory
    elif [[ $1 == "--record" ]]; then 
        Record
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else 
    echo "Too few arguments..."
    echo "Try './tools.sh -h' for more information..."
fi