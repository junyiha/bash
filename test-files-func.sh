#! /bin/bash +x

function FindBashFile()
{
    for filename in $(find . -name '*.sh')
    do
        echo ${filename}
    done 
}

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
        cp filename ./lib
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

function ZipNVIDIA()
{
    rm zip_files/*

    zip -r Fire_NVIDIA-GeForce-RTX-2080-x86_64.zip Fire_NVIDIA-GeForce-RTX-2080-x86_64

    zip -r FullyBody_Face-HeadShoulder_NVIDIA-GeForce-RTX-2080-x86_64.zip FullyBody_Face-HeadShoulder_NVIDIA-GeForce-RTX-2080-x86_64

    zip -r VEHICLE.zip VEHICLE

    mv *.zip zip_files/
}

function ZipBITMAINLAND()
{
    rm zip_files/*

    files=(Bike_Moto_Car_BITMAINLAND  Fire_BITMAINLAND FullyBody_Face-HeadShoulder_BITMAINLAND FullyBody_Guard-Helmet-Reflect-Phone_BITMAINLAND  JiaQiZhan_10class_BITMAINLAND Face_BITMAINLAND Foreign_BITMAINLAND  FullyBody_Falled_BITMAINLAND FullyBody_Mask-Face-Phone-Smoking_BITMAINLAND Moto_BITMAINLAND Vehicle_BITMAINLAND)

    length=${#files[@]}
    echo $length
    i=0

    while [ $i -le $length ]
    do
        echo ${files[$i]}.zip
        zip -r ${files[$i]}.zip ${files[$i]}
        ((i++))
    done

    mv *.zip ./zip_files/
}