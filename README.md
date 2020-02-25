# pentest

## Overview

Docker image with pentest tools.

## Features

- Connection to hack the box vpn
- Popular wordlists installed

## Tools installed

    traceroute
    net-tools
    iputils-ping
    git
    zsh
    curl
    locate
    openvpn
    vim
    wget
    ftp
    apache2
    squid
    python3
    python3-pip
    libcurl4-openssl-dev
    libssl-dev
    nmap &&

## Usage

```bash
git clone --depth 1 https://github.com/aaaguirrep/pentest.git
cd pentest
docker build -t ImageName .
docker run --rm -it -v /path/to/local/directory:/pentest --cap-add=NET_ADMIN --device=/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 my-server /bin/zsh
```

Aditionally you can run the docker container exposing services as apache and squid using -p option.

```bash
docker run --rm -it -v /path/to/local/directory:/pentest --cap-add=NET_ADMIN --device=/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --name my-pentest -p 80:80 -p 3128:3128 pentest /bin/zsh
```

Inside docker container start apache2 and squid services by the aliases.

```bash
apacheUp
squidUp
```

## Considerations

### Alias to connect to HTB (Hack to the box) VPN

Add the next line in step "Create shorcuts" in Dockerfile

```docker
RUN echo "alias vpnhtb=\"openvpn /pentest/path/to/ovpn/file\"" >> /root/.zshrc
```

### Save and load command history locally

Add the next line in step "Create shorcuts" in Dockerfile

```docker
RUN sed -i '1i export HISTFILE="/pentest/.zsh_history"' /root/.zshrc
```

## Examples
