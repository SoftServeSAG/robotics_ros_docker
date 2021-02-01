FROM lyubomyrd/ros_melodic_nvidia:latest

WORKDIR /root

ENV DOCKER_USER user

# Distribution of ROS2
ARG distro="melodic"

# Specify the distribution of ROS2
ENV ROS_DISTRO $distro

RUN apt-get update && apt-get install -y \
    openssh-server \
    gdb \
    gdbserver \
    python3 \
    python3-pip \
    python3-apt \
    apt-transport-https \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get upgrade -y

RUN wget http://packages.osrfoundation.org/gazebo.key 
RUN apt-key add gazebo.key
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list
RUN apt-get update
RUN pip3 install pip --upgrade
RUN pip3 install -U setuptools pip
RUN pip3 install colcon-ros-bundle
RUN pip3 install awscli

# install colcon
RUN apt-get update && apt-get install -y python3-pip \
    python3-apt \ 
    python3-colcon-common-extensions \
    python-pip    

RUN pip3 install -U setuptools
RUN apt-get install -y apt-utils dialog
RUN apt-get install -y python-rosinstall

# install mock for unittest
RUN python2 -m pip install mock 

ENV LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}"
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


# copy tmux config
COPY scripts/session.yml ~/.tmuxinator.yml
COPY scripts/dotbashrc ~/dotbashrc
COPY scripts/dottmux.conf ~/.tmux.conf

RUN echo 'export RUN_TMUX=true' >> ~/.bashrc
RUN echo 'source ~/dotbashrc' >> ~/.bashrc


RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

#RUN echo 'export RUN_TMUX=true' >> /home/$DOCKER_USER/.bashrc
RUN echo "PS1='\[\e[33m\][AWS_RMaker]\[\e[m\] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.bashrc
RUN echo 'alias ra='"'"'ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'"'"'' >> ~.bashrc
# cd /home/ros default
WORKDIR ~/
