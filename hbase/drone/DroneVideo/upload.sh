#!/bin/bash
#Filename: IsFile.sh

filepath="/home/ubuntu/DroneVideo/ok"
while :
do
now="$(date +'%b%d%H%M%S')"
if [ -e $filepath ]; then
    echo "$now"
    echo "exists."
    mv vid.h264 "$now".h264
    hadoop fs -put "$now".h264 /DroneVideo
    rm ok
else
    echo "not exists."
fi
sleep 3
done

