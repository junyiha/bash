#!/bin/bash +x 

var_01=1
var_02=2
function vca(){
    if [ $var_01 -eq 2 ];then
        return 6
    elif [ $var_01 -eq 1 ];then
        return 1
    fi
}

for i in {1..7}
do
    vca
    if [ $? -eq 6 ];then
        echo "6"
    fi
    echo $?
    # elif [ $? -eq 0 ];then
    #     echo "0"
    # fi
done