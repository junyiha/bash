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