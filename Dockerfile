FROM ubuntu:latest


# Create user and set password for user and root user
# (Note: Do not set -build-arg usernamei=ubuntu - This user already exists).
ARG usernamei
ARG passwdi
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


#Install vim
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vim


#Install sudo
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo


#Install python
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y python-is-python3


#Install pip
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y pip


# Install git
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git

# # Add these lines before running apt-add-repository command
# RUN apt-get update && apt-get upgrade -y && \
#     apt-get install -y software-properties-common
# #     && \ rm -rf /var/lib/apt/lists/*


# Create repositories directory
USER $usernamei
RUN mkdir /home/$usernamei/repos
COPY .bashrc /home/$usernamei/.bashrc
USER root
RUN chown $usernamei: /home/$usernamei/.bashrc

# RUN yes | unminimize

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]

