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
    #logrotate \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get upgrade -y

# Install the AWS CLI version 2 on Linux
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# install colcon
RUN apt-get update && apt-get install -y python3-pip \
    python3-apt \ 
    python3-colcon-common-extensions
RUN pip3 install -U setuptools
RUN pip3 install -U colcon-common-extensions colcon-ros-bundle


ENV LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}"
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# copy entrypoint file
RUN mkdir -p /opt/scripts/container/
COPY scripts/ros_entrypoint.sh /opt/scripts/container/ros_entrypoint.sh
RUN chmod -R a+rx /opt/scripts/container/ros_entrypoint.sh

# copy tmux config file
#COPY scripts/tmuxinator.yml /opt/scripts/container/tmuxinator.yml

# copy crontab config file
#COPY scripts/crontab /etc/cron.d/cjob
#RUN sudo chmod 644 /etc/cron.d/cjob

# copy logrotate config file
#COPY scripts/ros2_logrotate /etc/logrotate.d/ros2_logrotate
#RUN sudo chmod 644 /etc/logrotate.d/ros2_logrotate

# set user ros and sudo
RUN adduser --gecos "ROS User" --home /home/$DOCKER_USER --disabled-password $DOCKER_USER && \
    usermod -a -G dialout $DOCKER_USER && \
        echo "$DOCKER_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99_aptget
            
# switch to user ros, but the HOME is still /, not /home/ros
            USER $DOCKER_USER

# copy tmux config
COPY scripts/dottmux.conf /home/$DOCKER_USER/.tmux.conf

# copy dotbashrc
#COPY scripts/dotbashrc /home/$DOCKER_USER/dotbashrc

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /home/$DOCKER_USER/.bashrc

#RUN echo 'export RUN_TMUX=true' >> /home/$DOCKER_USER/.bashrc
RUN echo "PS1='\[\e[33m\][AWS_RMaker]\[\e[m\] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /home/$DOCKER_USER/.bashrc
RUN echo 'alias ra='"'"'ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'"'"'' >> /home/$DOCKER_USER/.bashrc
# cd /home/ros default
WORKDIR /home/$DOCKER_USER


ENTRYPOINT [ "/opt/scripts/container/ros_entrypoint.sh"]

#CMD ["ros2", "launch", "pl_launcher", "launch_all.launch.py"]
