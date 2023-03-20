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