#! /bin/bash

echo "password: admin,am0eb1u5# root,focus"

user="admin"
address="192.167.66.112"

cmd="ssh ${user}@${address}"

echo ${cmd}
eval ${cmd}