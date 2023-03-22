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

function Help()
{
    echo "Usage: ./daemon-bash.sh [-h]"
    echo "demo script for daemon running..."
    echo -e
    echo "  -r, --redshift  running redshift to protect eyes..."
    echo "  -h, --help"
}

function main()
{
    if [[ $1 == "-r" || $1 == "--redshift" ]]; then 
        StartRedshift
    elif [[ $1 == "-h" || $1 == "--help" ]]; then 
        Help
    fi
}

if [[ $# > 0 ]]; then 
    main $*
else 
    echo "Too few arguments..."
    echo "Try './daemon-bash.sh -h' for more information..."
fi