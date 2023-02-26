function VideoProcess()
{
    files=(VideoProcess-5.0.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz VideoProcess-ice-5.0.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz VideoProcess-mklicence-5.0.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz VideoProcess-devel-5.0.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz VideoProcess-kms-5.0.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz VideoProcess-vca-5.0.4-ubuntu-18.04-x86_64-NVIDIA.tar.gz)
    
    length=${#files[@]}
    echo $length
    i=0

    rm -rf VideoProcess
    while [ $i -le $length ]
    do
        echo ${files[$i]}
        tar -zxf ${files[$i]}
        ((i++))
    done
}

VideoProcess