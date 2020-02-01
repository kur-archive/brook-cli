# brook-cli

## Install

```shell
$ docker pull kurisux/brook-cli:latest
```

## How to use

### docker compose

```yaml
version: '2.1'
services:
  brook0:
    image: kurisux/brook-cli:latest
    ports:
      - "yourMachinePort:containerPort" # like "1234:1234"
    restart: always
    command:
      - client
      - -l
      - 0.0.0.0:containerPort # like 0.0.0.0:1234
      - -i
      - 0.0.0.0
      - -s
      - serverIP:serverPort  # like "1.1.1.1:2333"
      - -p
      - yourPassword
      - --http
```

```shell
$ docker-compose up -d
```

### docker cli

```shell
$ docker run -d -p yourMachinePort:containerPort \
    --restart always \
    --name brook-test1 \
    kurisux/brook-cli:latest \
    client \
    -l 0.0.0.0:containerPort \
    -i 0.0.0.0 \
    -s serverIP:serverPort  \
    -p yourPassword
    - --http
```