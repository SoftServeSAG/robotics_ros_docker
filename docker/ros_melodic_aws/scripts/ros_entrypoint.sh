#!/usr/bin/env bash

# start cron service for log rotation
sudo service cron start

set -e

echo  "------- STARTING Entrypoint -------"

whoami

source /opt/ros/$ROS_DISTRO/setup.bash
#source /opt/ros/melodic/setup.bash
source /home/$DOCKER_USER/.bashrc
#source /home/$DOCKER_USER/ws/install/setup.bash


echo  "------- ENDING Entrypoint -------"

# start CMD
exec "$@"
