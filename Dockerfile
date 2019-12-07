# step 0

FROM alpine:latest

RUN echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPATH=/root/go" >> /etc/profile \
    && echo "export GOPROXY=https://goproxy.cn" >> /etc/profile \
    && source /etc/profile

# 安装 micro
RUN apk update && apk add go git musl-dev xz binutils \
    && cd \
    && source /etc/profile \
    && go get -u -v github.com/txthinking/brook/cli/brook \
    && go install github.com/txthinking/brook/cli/brook

# 压缩 和 加壳
RUN wget https://github.com/upx/upx/releases/download/v3.95/upx-3.95-amd64_linux.tar.xz \
    && xz -d upx-3.95-amd64_linux.tar.xz \
    && tar -xvf upx-3.95-amd64_linux.tar \
    && cd upx-3.95-amd64_linux \
    && chmod a+x ./upx \
    && mv ./upx /usr/local/bin/ \
    && cd /root/go/bin \
    && strip --strip-unneeded brook \
    && upx brook \
    && chmod a+x ./brook \
    && cp brook /usr/local/bin

# step 1

FROM alpine:latest

COPY --from=0 /usr/local/bin/brook /usr/local/bin/

ENV LOCAL_BROOK_LISTEN_IP=$LOCAL_BROOK_LISTEN_IP
ENV LOCAL_BROOK_LISTEN_PORT=$LOCAL_BROOK_LISTEN_PORT
ENV SERVER_IP=$SERVER_IP
ENV SERVER_PORT=$SERVER_PORT
ENV SERVER_PASSWORD=$SERVER_PASSWORD

RUN echo $LOCAL_BROOK_LISTEN_IP
RUN echo ${LOCAL_BROOK_LISTEN_IP}

ENTRYPOINT ["brook", "client", "-l", "${LOCAL_BROOK_LISTEN_IP}:${LOCAL_BROOK_LISTEN_PORT}", "-i", "${LOCAL_BROOK_LISTEN_IP}", "-s", "${SERVER_IP}:${SERVER_PORT}", "-p","${SERVER_PASSWORD}","--http"]
