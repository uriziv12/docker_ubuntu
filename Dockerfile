FROM ubuntu:latest

# RUN yes | unminimize # Throws error from some reason.

# Create user and set password for user and root user
# (Note: Do not set -build-arg usernamei=ubuntu - This user already exists).
ARG usernamei=docker_ubuntu
ARG passwdi=1234
RUN  useradd -rm -d /home/$usernamei -s /bin/bash -g root -G sudo -u 1001 $usernamei && \
    echo $usernamei:$passwdi | chpasswd && \
    echo root:$passwdi | chpasswd \
    echo ubuntu:$passwdi | chpasswd


# Update the system, install OpenSSH Server
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-server


# Update the system, install OpenSSH Client
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-client


# Set up configuration for SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile


# Install vim
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vim


# Install sudo
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo

# Install regular python
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y python3

#Install pip
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y pip

# Install python3-venv
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y python3-venv

# Create python virtual env
# Inside container - it's better to run python by /home/$usernamei/python_venv/bin/python3 (otherwise some tools, like pip, might be blocked).
USER $usernamei
RUN mkdir /home/$usernamei/python_venv
USER root
RUN python3 -m venv /home/$usernamei/python_venv
RUN chown $usernamei: /home/$usernamei/python_venv -R


# Install git
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git

# Create repositories directory
USER $usernamei
RUN mkdir /home/$usernamei/repos
COPY .bashrc /home/$usernamei/.bashrc
USER root
RUN chown $usernamei: /home/$usernamei/.bashrc

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]

