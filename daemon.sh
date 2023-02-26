#! /bin/bash +x

function ffserver()
{
    cd /home/user/Videos/
    nohup ffserver -f ffserver.conf &
}

function redshift()
{
    nohup redshift &
}

# ffserver

redshift