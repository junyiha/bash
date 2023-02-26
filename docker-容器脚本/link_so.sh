#! /bin/bash +x

encode_so="/usr/lib/x86_64-linux-gnu/libnvidia-encode.so"
encode_so_1="/usr/lib/x86_64-linux-gnu/libnvidia-encode.so.1"

nvcuvid_so="/usr/lib/x86_64-linux-gnu/libnvcuvid.so"
nvcuvid_so_1="/usr/lib/x86_64-linux-gnu/libnvcuvid.so.1"

# encode_so="libnvidia-encode.so"
# encode_so_1="libnvidia-encode.so.1"

# nvcuvid_so="libnvcuvid.so"
# nvcuvid_so_1="libnvcuvid.so.1"

function encode()
{
    echo "begin encode()"
    if [ -L $encode_so_1 ]
    then
        echo "rm $encode_so_1"
        eval "rm $encode_so_1"
    fi

    ln -s $1 libnvidia-encode.so.1

    if [ -L $encode_so ]
    then
        echo "rm $encode_so"
        eval "rm $encode_so"
    fi
    
    ln -s libnvidia-encode.so.1 libnvidia-encode.so
}

function nvcuvid()
{
    echo "begin nvcuvid()"
    if [ -L $nvcuvid_so_1 ]
    then 
        echo "rm $nvcuvid_so_1"
        eval "rm $nvcuvid_so_1"
    fi

    ln -s $1 libnvcuvid.so.1

    if [ -L $nvcuvid_so ]
    then
        echo "rm $nvcuvid_so"
        eval "rm $nvcuvid_so"
    fi

    ln -s libnvcuvid.so.1 libnvcuvid.so
}

function help()
{
    echo "Example: bash link_so.sh libnvidia-encode.so.470.84.1 libnvcuvid.so.470.84.1"
}

if [ $1 == "--help" ]
then
    help
else
    encode $1
    nvcuvid $2
fi