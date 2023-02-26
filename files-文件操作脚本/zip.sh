#! /bin/bash

function nvidia()
{
    rm zip_files/*

    zip -r Fire_NVIDIA-GeForce-RTX-2080-x86_64.zip Fire_NVIDIA-GeForce-RTX-2080-x86_64

    zip -r FullyBody_Face-HeadShoulder_NVIDIA-GeForce-RTX-2080-x86_64.zip FullyBody_Face-HeadShoulder_NVIDIA-GeForce-RTX-2080-x86_64

    zip -r VEHICLE.zip VEHICLE

    mv *.zip zip_files/
}

function bitmainland()
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

# bitmainland

nvidia

