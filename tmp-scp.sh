#! /bin/bash +x

src_file_path="user@192.167.15.58:/home/user/workspace/1838-jingshi/demo/"
src_file="$1"

dst_file="."

cmd="scp ${src_file_path}${src_file} ${dst_file}"

echo "${cmd}"
eval "${cmd}"