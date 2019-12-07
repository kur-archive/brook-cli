# brook-cli

## Install

```shell
$ docker pull kurisux/brook-cli:latest
```

## How to use

### docker-compose

```yaml
version: '2.1'
services:
  la:
    image: kurisux/brook-cli:latest
    ports:
      - "yourMachinePort:containerPort" # like "1234:1234"
    restart: always
    environment:
      - LOCAL_BROOK_LISTEN_IP=127.0.0.1
      - LOCAL_BROOK_LISTEN_PORT=containerPort # like 1234
      - SERVER_IP=serverIP  # like "1.1.1.1"
      - SERVER_PORT=serverPort # like "2333"
      - SERVER_PASSWORD=yourPassword
```

```shell
$ docker-compose up -d
```

### docker

```shell
$ docker run -p yourMachinePort:containerPort \
    --restart always \
    -e LOCAL_BROOK_LISTEN_IP=127.0.0.1 \
    -e LOCAL_BROOK_LISTEN_PORT=containerPort \
    -e SERVER_IP=serverIP \
    -e SERVER_PORT=serverPort \
    -e SERVER_PASSWORD=yourPassword \
    kurisux/brook-cli:latest
```