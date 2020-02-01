# step 0

FROM ubuntu:latest

USER root

# install
RUN apt update \
    && apt install -y jq curl wget tar xz-utils binutils \
    && wget `curl https://api.github.com/repos/txthinking/brook/releases/latest | jq -r ".assets[0].browser_download_url"` -o brook \
    && chmod a+x brook

# step 1

FROM alpine:latest

COPY --from=0 /brook /usr/local/bin/

ENTRYPOINT ["brook", "client"]


# curl https://api.github.com/repos/txthinking/brook/releases/latest |jq -r ".assets[0].browser_download_url"