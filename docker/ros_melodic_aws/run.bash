#!/usr/bin/env bash


SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR_PATH=$(dirname "$SCRIPT_PATH")
WS_DIR_PATH=$(realpath "$SCRIPT_DIR_PATH/../")

xhost +local:root

docker run -it --rm \
    --privileged \
    --volume=/tmp/.X11-unix:/tmp/.X11-unix \
    --device=/dev/dri:/dev/dri \
    --env="DISPLAY=$DISPLAY" \
    --env QT_X11_NO_MITSHM=1 \
    --volume="$WS_DIR_PATH:/root/ws" \
    --net host\
    --runtime=nvidia \
    ros_aws tmuxinator

xhost -local:root
