#! /bin/bash +x

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
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else 
    echo "Too few arguments..."
    echo "Try './tools.sh -h' for more information..."
fi