#! /bin/bash +x

sudo mount -o intr 192.167.15.166:/volume1/open_space /mnt/remote/192.167.15.166-mnt

sleep 1

sudo mount -o intr 192.167.15.190:/volume1/GHspace /mnt/remote/192.167.15.190-mnt