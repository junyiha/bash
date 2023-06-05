#! /bin/bash -x

function EtherCATStatus()
{
    while [[ true ]]
    do
        ethercat slv
        sleep 1
    done
}

function EtherCATPosition()
{
    while [[ true ]]
    do 
        for i in {0..5}
        do 
            ethercat upload $1 -p ${i} $2 00
        done 
        echo -e 
        sleep 1
    done 
}

# 找到当前执行程序的绝对路径
function FindPath()
{
    realpath .
}

function ReCompileRobotProject()
{
    echo "cd build folder and compile..."
    cd build
    cmake .. && make -j9
}

function MakeRobotProject()
{
    if [ -d "build" ]; then 
        echo "Delete build folder..."
        rm -r build
    fi

    echo "create build folder..."
    mkdir build
    cd build
    echo "cd build folder and compile..."
    cmake .. && make -j9
}

function PackageRobot()
{
    # 设置打包的根路径
    root_path="robot"
    # 执行路径在 build/
    echo "create ${root_path} folder..."
    mkdir ${root_path}

    echo "make bin folder..."
    cp -r examples ${root_path}/bin

    echo "make lib folder..."
    mkdir ${root_path}/lib
    find ./lib -name '*.so' | xargs -i cp {} ${root_path}/lib

    echo "cp third_party and webroot"
    cp -r ../third_party ${root_path}/
    cp -r ../modules/webroot ${root_path}/

    echo "cp script"
    cp -r ../script ${root_path}/
    cp ../*.sh ${root_path}

    echo "create tar file"
    tar -zcf ${root_path}.tar.gz ${root_path}

    echo "${root_path} folder create done..."
}

function FindBashFile()
{
    for filename in $(find . -name '*.sh')
    do
        echo ${filename}
    done 
}

# 将后缀名为sh的文件，重命名为.c
function FindBashFile_V2()
{
    for file in $(ls ./)
    do 
        if [ "${file##*.}" = "sh" ]; then
            # mv ${file} ${file%.*}.c
            echo ${file}
        fi
    done
}

function FindSharedLibFile()
{
    for filename in $(find . -name '*.so')
    do
        cp ${filename} ./lib
    done 

    return 0;
}

function DeleteDir()
{
    cd /data/robot/lib/
    for file in $(ls ./)
    do 
        if [ -d "${file}" ]; then
            rm -r ${file}
        fi
    done 
}

function Mount190()
{
    sudo mount -o intr 192.169.4.166:/volume1/open_space /mnt/remote/192.167.15.166-mnt

    sleep 1

    sudo mount -o intr 192.169.4.190:/volume1/GHspace /mnt/remote/192.167.15.190-mnt
}

function RenameFile()
{
    for var in *.sh; 
    do 
        mv "$var" "${var%.sh}.cc"; 
    done
}

# 人脸识别，人脸库照片数据的获取
function FaceICETest()
{
    path=$1
    files=$(ls $path)

    i=1
    for filename in $files
    do
        file_array[i]=$filename
        ((i++))
    done

    len=${#file_array[@]}
    echo $len

    j=1
    while ((j < len))
    do
        echo "$j|0|Pictures/new_year/${file_array[$j]}" >> filename.txt

        ((j++))
    done
}

# 传入工作路径，将该路径下的所有目录压缩为zip文件
function CompressFilesInZip()
{
    if [[ -z $1 ]]; then 
        echo "empty argument..."
    else
        echo "path : $1"
        files=$(ls $1)
        for i in ${files}
        do 
            if [ -d $i ]; then 
                zip -r ${i}.zip $i
            fi
        done
    fi
}

function Help()
{
    echo "Usage: ./test-files-func.sh [-h]"
    echo "demo script for testing..."
    echo -e
    echo "  -p, --path  find realpath"
    echo "  -h, --help"
}

function main()
{
    if [[ $1 == "--path" || $1 == "-p" ]]; then 
        FindPath
    elif [[ $1 = "--help" || $1 = "-h" ]]; then 
        Help
    fi
}

if [ $1 == "-p" ]; then 
    echo "$1 -eq -p"
fi

if [[ $# > 0 ]]; then 
    main $*
else 
    echo "Too few arguments..."
    echo "Try './test-files-func.sh -h' for more information..."
fi