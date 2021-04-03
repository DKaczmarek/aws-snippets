#!/bin/bash

# check if volume is attached
lsblk
read -n1 -s -r -p $'Continue ?\n' key

# check if the file system exists at volume
VOLUME_NAME="/dev/xvdf"
VOLUME_TYPE=$(sudo file -s $VOLUME_NAME | awk '{print $2;}')
echo $VOLUME_NAME $VOLUME_TYPE
read -n1 -s -r -p $'Continue ?\n' key

if [ $VOLUME_TYPE == 'data' ]; then
  echo 'creating filesystem'
  sudo mkfs -t ext4 $VOLUME_NAME
fi

# create mount point
MOUNT_POINT=/data
sudo mkdir $MOUNT_POINT
echo mount point at $MOUNT_POINT

# mount volume
sudo mount $VOLUME_NAME $MOUNT_POINT

# verify
lsblk
