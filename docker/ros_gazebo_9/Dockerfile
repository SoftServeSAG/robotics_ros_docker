FROM nvidia/opengl:1.0-glvnd-devel-ubuntu16.04

WORKDIR /root

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
    net-tools

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop \
    python-catkin-tools \
    ros-kinetic-multimaster-fkie

RUN set -x && \
    echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - && \
    apt-get update && \
    apt-get remove -y gazebo* && \
    apt-get install -y libgazebo9 libsdformat6 libignition-math3  libignition-math3-dev libsdformat6 libsdformat6-dev gazebo9 libgazebo9-dev gazebo9-common ros-kinetic-gazebo9-msgs ros-kinetic-gazebo9-ros ros-kinetic-gazebo9-dev ros-kinetic-gazebo9-ros-pkgs ros-kinetic-gazebo9-ros-control ros-kinetic-gazebo9* ros-kinetic-catkin rviz ros-kinetic-controller-manager ros-kinetic-joint-state-controller ros-kinetic-joint-trajectory-controller ros-kinetic-rqt ros-kinetic-rqt-controller-manager ros-kinetic-rqt-joint-trajectory-controller ros-kinetic-ros-control ros-kinetic-rqt-gui ros-kinetic-rqt-plot ros-kinetic-rqt-graph ros-kinetic-rqt-rviz ros-kinetic-rqt-tf-tree ros-kinetic-gazebo9-ros ros-kinetic-kdl-conversions ros-kinetic-kdl-parser ros-kinetic-forward-command-controller ros-kinetic-tf-conversions ros-kinetic-xacro ros-kinetic-joint-state-publisher ros-kinetic-robot-state-publisher ros-kinetic-ros-control ros-kinetic-ros-controllers ros-kinetic-combined-robot-hw ros-kinetic-joint-state-controller


RUN rosdep init && rosdep fix-permissions && rosdep update

COPY dotbashrc /root/dotbashrc
COPY dottmux.conf /root/.tmux.conf

RUN echo 'export RUN_TMUX=true' >> ~/.bashrc
RUN echo 'source /root/dotbashrc' >> ~/.bashrc
RUN echo 'alias ra='"'"'ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'"'"'' >> ~/.bashrc
