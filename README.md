# docker_ubuntu
Dockerfile based on Ubuntu image with several common
development tools.

## Tools List
- openssh-server
- openssh-client
- vim
- sudo
- python3
- pip
- python3-venv
- git
- zip
- curl

## Usage

### pull image from docker hub
```sh
docker pull uriziv12/docker_ubuntu:latest
```

### (Alternative to pull image) Build locally the Image
```sh
docker build [--build-arg usernamei=<user>] \
             [--build-arg passwdi=<password>] \
             -t docker_ubuntu .
```
> **Note:**
>
> This Dockerfile builds an image with a custom user in addition to
> the default 'root' and 'ubuntu' users. By default, the username is
> `docker_ubuntu` and the password is `1234`. You can override these
> defaults with the optional build arguments `usernamei` and `passwdi`.

> **Note:**
>
> The username and image name may share the same value in examples
> for simplicity, but they are independent and can be set as desired.

### Set Up Docker Network (for SSH access between containers)
```sh
docker network create -d bridge --subnet=172.18.0.0/16 net1
```

### Run Containers from the Image
```sh
docker run -d --name cont1 -h cont1 --network net1 \
  -p 3021:22 -p 4021:8080 --ip 172.18.0.21 docker_ubuntu:<tag>

docker run -d --name cont2 -h cont2 --network net1 \
  -p 3022:22 -p 4022:8080 --ip 172.18.0.22 docker_ubuntu:<tag>
```

### Inspect IP Address of Containers
```sh
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cont1
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cont2
```
Alternative:
```sh
docker inspect cont1 | grep IPAddress
docker inspect cont2 | grep IPAddress
```

### Connect via SSH
```sh
ssh -p 3021 docker_ubuntu@localhost
ssh -p 3022 docker_ubuntu@localhost
```

### Serving Files via Python HTTP Server
To start http server from any folder, use the following alias:
```sh
cd /path/to/your/folder
http-srv
```

> **Note:**
> 
> Make sure no firewall or security rule is blocking port 8080.
> Also, ensure the server is listening on `0.0.0.0` (the default for
> `http.server`) so it is accessible from outside the container.
> 
> This will start an HTTP server accessible on port 8080. If you mapped
> container port 8080 to the host (e.g., `-p 4021:8080`), you can access
> it via `http://localhost:4021` from your host machine.

### Using Python Virtual Environments

A Python virtual environment is pre-created for you at `~/venv` during the Docker image build process.  
To activate this environment, use the alias:

```sh
venv
```

To deactivate the virtual environment when done, simply run:

```sh
deactivate
```

## Docker Hub
https://hub.docker.com/r/uriziv12/docker_ubuntu

## Release Notes

### v1.0.7
- git alias `lg` for a graphical log view.

### v1.0.6
- Added alias 'venv' for python venv and 'http-srv' for http-server.
- Removed nodejs, npm, and http-server from Dockerfile and updated
  README accordingly.
- Added usage example for serving files using Python HTTP server.
