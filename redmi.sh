#! /bin/bash +x

name="u0_a401"
address="192.167.0.11"

CMD="ssh -p 8022 $name@$address"

echo $CMD
eval $CMD
