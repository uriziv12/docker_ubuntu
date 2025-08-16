FROM ubuntu:latest

# RUN yes | unminimize # Throws error from some reason.

# Create user and set password for user and root user
# (Note: Do not set -build-arg usernamei=ubuntu - This user already exists).
ARG usernamei=docker_ubuntu
ARG passwdi=1234
RUN  useradd -rm -d /home/$usernamei -s /bin/bash -g root -G sudo -u 1001 $usernamei && \
    echo $usernamei:$passwdi | chpasswd && \
    echo root:$passwdi | chpasswd && \
    echo ubuntu:$passwdi | chpasswd

# Update the system, install OpenSSH Server, Client, vim, sudo, python3, pip, python3-venv, git, zip, curl
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-server openssh-client vim sudo python3 python3-pip python3-venv git zip curl \
    file tree bsdmainutils dos2unix && \
    apt-get clean

# Set up configuration for SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile

# Create python virtual env
# Inside container - it's better to run python by /home/$usernamei/venv/bin/python3 (otherwise some tools, like pip, might be blocked).
USER $usernamei
RUN mkdir /home/$usernamei/venv

# Add git global alias
RUN git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%aN%Creset' --abbrev-commit --date=relative"

USER root
RUN python3 -m venv /home/$usernamei/venv
RUN chown $usernamei: /home/$usernamei/venv -R

# Install black
RUN /home/$usernamei/venv/bin/pip install black

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

