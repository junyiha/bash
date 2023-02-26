#! /bin/bash +x
for var in *.sh; 
do 
    mv "$var" "${var%.sh}.cc"; 
done