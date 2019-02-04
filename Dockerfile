ARG bashver=latest

FROM bash:${bashver}

RUN apk add --no-cache git; \
git config --global user.email "user@example.com"; \
git config --global user.name "User Name";

COPY . /opt/basher/

ENTRYPOINT ["bash", "/opt/basher/bats/bin/bats"]
