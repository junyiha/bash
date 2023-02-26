#! /bin/bash +x
:<<EOF
# ./vca.exe --model-conf /tmp/Fire_BITMAINLAND/DETECT.conf  --id 1 --input-video-name "rtsp://192.167.15.58:554/yunshitu.mp4" --detector-conf "/--detector-models/2000003001_DETECT/xxxx/yyyy" --output-video-name "/tmp/aaa.mp4" --output-type 2

function manual()
{
    program="/data/dagger/VideoProcess/bin/vca.exe"

    model_conf="--model-conf $1"

    program_id="--id $2"

    input_video="--input-video-name $3"

    detector_conf="--detector-conf $4"

    output_type="--output-type 2"

    output_video="--output-video-name $5"

    cmd="$program $model_conf $program_id $input_video $detector_conf $output_type $output_video"

    echo $cmd
}

function auto()
{
    cmd="/data/dagger/VideoProcess/bin/vca.exe --model-conf /tmp/Fire_BITMAINLAND/DETECT.conf  --id 1 --input-video-name $1 --detector-conf /--detector-models/2000003001_DETECT/xxxx/yyyy --output-video-name $2 --output-type 2"
    echo $cmd
    eval $cmd
}

# manual()

input_video="$1"

output_video="$2"

auto $input_video $output_video

EOF

# version -- 5.0.4
function run_one()
{
    task_id=$1
    cmd="/data/dagger/VideoProcess/bin/vca.exe --id ${task_id} --detector-conf-inline --detector-conf @--detector-models@/data/models/NVIDIA-1080/Person/DETECT.conf@xxxx@yyyy@ --input-video-name rtsp://192.167.15.58:554/forget_01.mkv"
    echo $cmd
    eval $cmd
}

function run_batch()
{
    m_vca_path=$1
    m_task_id=$2
    m_model_conf=$3
    m_input_video=$4

    CMD="${m_vca_path} --server-order-protocol 1 \
        --server-response-timeout  \
        --server-zmq-address  tcp://127.0.0.1:9102 \
        --mid 1  \
        --cmd 2 \
        --id ${m_task_id} \
        --detector-conf-inline \
        --detector-conf @--detector-models@${m_model_conf}@xxxx@yyyy@ \
        --input-video-name ${m_input_video}"

    echo ${CMD}
    eval ${CMD}
}

function run_server()
{
    m_vca_path=$1
    m_limit_max=$2

    CMD="${m_vca_path} --daemon --device --kms-address --multi-task 1 \
        --multi-task-limit-max ${m_limit_max}  \
        --multi-task-zmq-listen tcp://*:9102"
    
    echo ${CMD}
    # eval ${CMD}
}

vca_path="/data/dagger/VideoProcess/bin/vca.exe"
model_conf_file="/data/models/zhuoer/DETECT.conf"
input_video="rtsp://admin:a1234567@192.167.10.126:554"

limit_max=70

# run_server ${vca_path} ${limit_max}

num=1
while ((${num}<= 10))
do
    run_batch ${vca_path} ${num} ${model_conf_file} ${input_video}
    let "num++"
done