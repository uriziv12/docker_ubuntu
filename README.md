# docker_ubuntu
Docker to build ubuntu image with the common tools.

## Tools list
- openssh-server
- openssh-client
- vim
- sudo
- git
- python
- pip


## Usage
```
docker build [--build-arg usernamei=<user>] [--build-arg passwdi=<password>] -t <image-name> .
```

```
docker network create -d bridge --subnet=172.18.0.0/16 net1
```

```
docker volume create docker_volume
```


```
docker run -d --name ubu1 -h ubu1 --network net1 -p 3021:22 --ip 172.18.0.21 -v /home/uriziv/docker_volume:/home/defult_user/docker_volume localhost/ubu-img

docker run -d --name ubu2 -h ubu2 --network net1 -p 3022:22 --ip 172.18.0.22 localhost/ubu-img

docker run -d --name ubu3 -h ubu3 --network net1 -p 3023:22 --ip 172.18.0.23 localhost/ubu-img

docker run -d --name ubu4 -h ubu4 --network net1 -p 3024:22 --ip 172.18.0.24 localhost/ubu-img
```

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubu1
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubu2
```

```
docker inspect ubu1 | grep IPAddress
docker inspect ubu2 | grep IPAddress
```

```
ssh ubuntu@localhost -p 3041
ssh ubuntu@localhost -p 3042
```

## Notes
In case pip doesn't work inside docker, you should use instead: {{sudo apt-get install python3-<mudule_name>}}, E.g:

```
sudo apt-get install python3-yaml
```

## Links
https://tecadmin.net/setting-up-ubuntu-docker-container-with-ssh-access/
https://medium.com/@mfahad1667/ssh-connection-between-two-docker-container-7c9dced1aa43
https://medium.com/@mfahad1667/ssh-connection-between-two-docker-container-7c9dced1aa43
