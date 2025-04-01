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


## Usage
To build image run:
```sh
docker build [--build-arg usernamei=<user>] [--build-arg passwdi=<password>] -t <image-name> .
```
> Note: This dockerfile builds image with new custom user. By default, username is `docker_ubuntu` and password is `1234`. You can change them using the optional arguments `usernamei` and `passwdi`.

&nbsp;

To connect your container via ssh, you have to set docker networkE.g.:
```sh
docker network create -d bridge --subnet=172.18.0.0/16 net1
```

&nbsp;

Create container(s) from your image. E.g.:
```sh
docker run -d --name cont1 -h cont1 --network net1 -p 3021:22 --ip 172.18.0.21 <image-name>

docker run -d --name cont2 -h cont2 --network net1 -p 3022:22 --ip 172.18.0.22 <image-name>
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
