FROM nvidia/opengl:1.2-glvnd-devel-ubuntu18.04 

WORKDIR /root

# set tzdata and timezone to avoid build stuck
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

RUN apt-get update -y && apt-get install -y \
    vim \
    tmux \
    tmuxinator \
    git \
    wget \
    lsb-release \
    lsb-core \
    vim \
    build-essential \
    ranger \
    g++ \
    net-tools \
    gnupg

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full \
    python-catkin-tools \
    ros-melodic-multimaster-fkie \
    python-rosdep

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
     ros-melodic-catkin 
     #\
     #ros-melodic-controller-manager \
     #ros-melodic-joint-state-controller \
     #ros-melodic-joint-trajectory-controller \
     #ros-melodic-rqt \
     #ros-melodic-rqt-controller-manager \
     #ros-melodic-rqt-joint-trajectory-controller \
     #ros-melodic-ros-control \
     #ros-melodic-rqt-gui \
     #ros-melodic-rqt-plot \
     #ros-melodic-rqt-graph \
     #ros-melodic-rqt-rviz \
     #ros-melodic-rqt-tf-tree \     
     #ros-melodic-kdl-conversions \
     #ros-melodic-kdl-parser \
     #ros-melodic-forward-command-controller \
     #ros-melodic-tf-conversions \
     #ros-melodic-xacro \
     #ros-melodic-joint-state-publisher \
     #ros-melodic-robot-state-publisher \
     #ros-melodic-ros-control \
     #ros-melodic-ros-controllers \
     #ros-melodic-combined-robot-hw \ 
     #ros-melodic-joint-state-controller

RUN rosdep init && rosdep fix-permissions && rosdep update

COPY docker/ros_melodic_nvidia/dotbashrc /root/dotbashrc
COPY docker/ros_melodic_nvidia/dottmux.conf /root/.tmux.conf

RUN echo 'export RUN_TMUX=true' >> ~/.bashrc
RUN echo 'source /root/dotbashrc' >> ~/.bashrc
RUN echo 'alias ra='"'"'ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'"'"'' >> ~/.bashrc
