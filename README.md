# docker_ubuntu
Dockerfile for ubuntu image with the common tools.

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

To connect your container via ssh, you have to set docker network, e.g:
```sh
docker network create -d bridge --subnet=172.18.0.0/16 net1
```

&nbsp;

To share a folder with your contianer
```sh
docker volume create docker_volume
```

&nbsp;

Create container(s) from your image
```sh
docker run -d --name cont1 -h cont1 --network net1 -p 3021:22 --ip 172.18.0.21 -v /home/uriziv/docker_volume:/home/defult_user/docker_volume <image-name>

docker run -d --name cont2 -h cont2 --network net1 -p 3022:22 --ip 172.18.0.22 <image-name>

docker run -d --name cont3 -h cont3 --network net1 -p 3023:22 --ip 172.18.0.23 <image-name>

docker run -d --name cont4 -h cont4 --network net1 -p 3024:22 --ip 172.18.0.24 <image-name>

```

&nbsp;

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubu1
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubu2
```

&nbsp;

```
docker inspect ubu1 | grep IPAddress
docker inspect ubu2 | grep IPAddress
```

&nbsp;

```
ssh ubuntu@localhost -p 3041
ssh ubuntu@localhost -p 3042
```

&nbsp;

## Links
https://tecadmin.net/setting-up-ubuntu-docker-container-with-ssh-access/
https://medium.com/@mfahad1667/ssh-connection-between-two-docker-container-7c9dced1aa43
