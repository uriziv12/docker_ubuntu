FROM ubuntu:latest

# Default username
ENV USERNAME=ubuntu1
# Default password
ENV PASSWD=1234

RUN echo $USERNAME
RUN echo $PASSWD

# Update the system, install OpenSSH Server
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-server

# Update the system, install OpenSSH Client
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-client

# Create user and set password for user and root user
RUN  useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u 1001 $USERNAME && \
    echo $USERNAME:$PASSWD | chpasswd && \
    echo root:$PASSWD | chpasswd

# Set up configuration for SSH
# service ssh start
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile

#Install vim
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vim

#Install sudo
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo

# Add these lines before running apt-add-repository command
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y software-properties-common
#     && \ rm -rf /var/lib/apt/lists/*

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]


