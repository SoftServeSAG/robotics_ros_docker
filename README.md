# Docker that is basis for other dockers that are to be build on top of it
In this docker the installation of ROS, Gazebo 9 and some additional packages in addition to basic linuc setup is included.


## Install
###Install nvidia-docker 
```bash
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install nvidia-docker2
sudo systemctl restart docker

###Build docker images

```bash
cd robotic_order_fulfillment_robotic_arm/docker/
cd ros_gazebo_9
sudo ./build.bash 
```
