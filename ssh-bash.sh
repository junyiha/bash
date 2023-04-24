#! /bin/bash -x

function SSH-7-32()
{
    user="user"
    ip="192.169.7.32"
    echo "user-name: $user"
    echo "pass-word: 111111"
    cmd="ssh $usr@$ip"
    echo ${cmd}
    eval ${cmd}
}