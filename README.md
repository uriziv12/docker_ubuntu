# docker_ubuntu
Dockerfile based on ubuntu image with some more common delevopment tools.

## Tools list
- openssh-server
- openssh-client
- vim
- sudo
- python
- pip
- python3-venv
- git
- zip
- curl
- nodejs
- npm
- http-server

## Usage
Build image. E.g.:
```sh
docker build [--build-arg usernamei=<user>] [--build-arg passwdi=<password>] -t docker_ubuntu .
```
> [1] This dockerfile builds image with new custom user (beside of 'root' and 'ubuntu' users). By default, username is `docker_ubuntu` and password is `1234`. You can change them using the optional arguments `usernamei` and `passwdi`.

> [2] In this example, both username and image name are 'docker_ubuntu'. However, their names will not necessarily always be the same and you can set them both as you wish.

&nbsp;

To connect your container via ssh, you have to set docker network. E.g.:
```sh
docker network create -d bridge --subnet=172.18.0.0/16 net1
```

&nbsp;

Create container(s) from your image. E.g.:
```sh
docker run -d --name cont1 -h cont1 --network net1 -p 3021:22 --ip 172.18.0.21 docker_ubuntu

docker run -d --name cont2 -h cont2 --network net1 -p 3022:22 --ip 172.18.0.22 docker_ubuntu
```

&nbsp;

You can inspect the IP address of your container(s). E.g.:

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cont1

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cont2
```

&nbsp;

```
docker inspect cont1 | grep IPAddress
docker inspect cont2 | grep IPAddress
```

&nbsp;

Connect to running container vis ssh:
```
ssh -p 3021 docker_ubuntu@localhost
ssh -p 3022 docker_ubuntu@localhost
```

&nbsp;

## Dockerhub
https://hub.docker.com/r/uriziv12/docker_ubuntu

&nbsp;

## Links
https://tecadmin.net/setting-up-ubuntu-docker-container-with-ssh-access/
https://medium.com/@mfahad1667/ssh-connection-between-two-docker-container-7c9dced1aa43

## TODO
* pip install autopep8
* sudo apt-get install file
* sudo apt-get install tree
* sudo apt-get install bsdmainutils
* sudo apt-get install dos2unix
* Add the following to bashrc
```
get_ps1 () {
  local date_segment='\[\033[01;34m\][$(date +%d/%m\ %H:%M:%S)]\[\033[00m\]'
  local chroot_segment='${debian_chroot:+($debian_chroot)}'
  local user_segment='\[\033[01;32m\]\u\[\033[00m\]'
  local host_segment='\[\033[01;36m\]\h\[\033[00m\]'
  local git_segment='\[\033[01;31m\]$(git branch 2>/dev/null|grep -e ^* | tr "*" ":" | tr -d " ")\[\033[00m\]'
  local working_directory_segment='\[\033[01;33m\]\w\[\033[00m\]'
  local prompt_indicator='~> '
  local end_line='(---------------)' # TODO: calcuate number of dashes till end of line.
  local newline='\n'

  echo -ne "${date_segment}:${chroot_segment}${user_segment}@${host_segment}${git_segment}:${working_directory_segment}:${end_line}${newline}${prompt_indicator}"
}
...
PS1="$(get_ps1)"
```
