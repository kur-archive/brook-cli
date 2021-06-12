# step 0

FROM ubuntu:latest

USER root

# install
RUN apt update \
    && apt install -y jq curl wget tar xz-utils binutils \
    && wget `curl https://api.github.com/repos/txthinking/brook/releases/latest | grep -o "https://github.com/txthinking/brook/releases/download/.*/brook_darwin_arm64"` -O brook \
    && chmod a+x brook

RUN chmod a+x ./brook \
    && cp brook /usr/local/bin

# step 1

FROM arm64v8/alpine:latest

COPY --from=0 /brook /usr/local/bin/

ENTRYPOINT ["brook"]
