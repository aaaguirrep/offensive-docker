<!-- markdownlint-disable MD033 MD041 -->

<p align="center">
  <a href="https://hub.docker.com/r/aaaguirrep/pentest">
    <img
      alt="Docker for pentest"
      src="img/banner.jpg"
      width="600"
    />
  </a>
</p>
<br/>
<p align="center">
  <a href="https://github.com/aaaguirrep/pentest"><img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/aaaguirrep/pentest"></a>
  <a href="https://github.com/aaaguirrep/pentest"><img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/aaaguirrep/pentest"></a>
  <a href="https://github.com/aaaguirrep/pentest"><img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/aaaguirrep/pentest"></a>
    <a href="https://github.com/aaaguirrep/pentest"><img alt="GitHub issues" src="https://img.shields.io/github/issues/aaaguirrep/pentest"></a>
  <a href="https://hub.docker.com/r/aaaguirrep/pentest"><img alt="Docker Cloud Build Status" src="https://img.shields.io/docker/cloud/build/aaaguirrep/pentest"></a>
  <a href="https://hub.docker.com/r/aaaguirrep/pentest"><img alt="Docker Automated build" src="https://img.shields.io/docker/automated/aaaguirrep/pentest"></a>
    <a href="https://hub.docker.com/r/aaaguirrep/pentest"><img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/aaaguirrep/pentest"></a>
  <a href="https://hub.docker.com/r/aaaguirrep/pentest"><img alt="Docker Image Size (latest by date)" src="https://img.shields.io/docker/image-size/aaaguirrep/pentest"></a>
    <a href="https://hub.docker.com/r/aaaguirrep/pentest"><img alt="Docker Image Version (latest by date)" src="https://img.shields.io/docker/v/aaaguirrep/pentest"></a>
    <a href="https://hub.docker.com/r/aaaguirrep/pentest"><img alt="Docker Stars" src="https://img.shields.io/docker/stars/aaaguirrep/pentest"></a>
  <a href="https://github.com/aaaguirrep/pentest/blob/master/LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/aaaguirrep/pentest"></a>
</p>

Docker for pentest is an image with the more used tools to create an pentest environment easily and quickly.

## Features

- OS, networking, developing and pentesting tools installed.
- Connection to HTB (Hack the Box) vpn to access HTB machines.
- Popular wordlists installed: SecLists, dirb, dirbuster, fuzzdb, wfuzz and rockyou.
- Proxy service to send traffic from any browsers and burp suite installed in your local directory.
- Exploit database installed.
- Tool for cracking password.
- Linux enumeration tools installed.
- Tools installed to discovery services running.
- Tools installed to directory fuzzing.
- Monitor for linux processes without root permissions
- Zsh shell installed.

## Tools installed

### Operative system tools

    rdate
    vim
    zsh
    oh-my-zsh
    locate
    cifs-utils
    python
    python-pip
    python3
    python3-pip
    pspy

### Network tools

    traceroute
    telnet
    net-tools
    iputils-ping
    tcpdump
    openvpn
    ftp
    netcat
    rlwrap
    smbclient
    smbmap
    whois
    host

### Developer tools

    git
    curl
    wget
    ruby
    go

### Pentest tools

    nmap
    wfuzz
    cewl
    wordlists
    searchsploit
    dirsearch
    htbenum
    linux-smart-enumeration
    linenum
    john
    evil-winrm
    enum4linux
    impacket
    ldapdomaindump
    sqlmap
    CrackMapExec
    PEASS - Privilege Escalation Awesome Scripts SUITE
    Nishang
    Windows Exploit Suggester - Next Generation    
    Juicy Potato
    Metasploit
    MS17-010
    AutoBlue-MS17-010
    PrivExchange
    PowerSploit
    gpp-decrypt
    hydra
    patator
    gitleaks
    gitrob
    masscan
    nikto
    crunch
    medusa
    hashid
    hashcat
    crowbar
    pass-the-hash
    mimikatz
    whatweb
    wafw00z
    hakrawler

### Custom functions or scripts

    ExtractPorts by s4vitar
    ScanPorts created by s4vitar but with additionals improvements

### Other services

    apache2
    squid

## Usage

### Prerequisites

- Docker service installed

You can use the docker image by the next two options:

### Option 1 - Use the github repository

    git clone --depth 1 https://github.com/aaaguirrep/pentest.git
    cd pentest
    docker build -t pentest .
    docker run --rm -it --name my-pentest pentest /bin/zsh

### Option 2 - Use the image from docker hub

Use image from docker hub: [aaaguirrep/pentest](https://hub.docker.com/r/aaaguirrep/pentest)

    docker pull aaaguirrep/pentest
    docker run --rm -it --name my-pentest pentest /bin/zsh

### Considerations to run the container

There are differents use cases for use the image and you should know how to run the container properly.

1. Use the container to access HTB (Hack the Box) machines by HTB vpn.

        docker run --rm -it --cap-add=NET_ADMIN --device=/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --name my-pentest aaaguirrep/pentest /bin/zsh

2. Share information from your local directory to container directory and save information on your local directory. You should save information under /pentest directory.

        docker run --rm -it -v /path/to/local/directory:/pentest --name my-pentest aaaguirrep/pentest /bin/zsh

3. Expose internal container services (apache, squid) for your local environment.

        docker run --rm -it --name my-pentest -p 80:80 -p 3128:3128 aaaguirrep/pentest /bin/zsh

    Inside the container start apache2 and squid services by the aliases.

        apacheUp
        squidUp

4. Mount directories by umount command.

        docker run --rm -it --privileged --name my-pentest aaaguirrep/pentest /bin/zsh

5. Tools are downloaded in /tools directory.

## Nice configurations

You can set up the docker image with nice configurations like as:

### 1. Alias to connect to HTB (Hack the Box) VPN

To use both options you should use -v option to map local directoty with /pentest container directory.

#### Option 1 - HTB VPN using github repository

Add the next line in step "Create shorcuts" in Dockerfile, build a new image and run a new container with the -v option.

    RUN echo "alias vpnhtb=\"openvpn /pentest/path/to/ovpn/file\"" >> /root/.zshrc

#### Option 2 - HTB VPN using docker hub image

Create a new Dockerfile with the next steps, build a new image and run a new container with -v option.

    FROM aaaguirrep/pentest

    # Create a shortcut and load the ovpn file from workstation
    RUN echo "alias vpnhtb=\"openvpn /pentest/path/to/ovpn/file\"" >> /root/.zshrc

### 2. Save and load command history in your local environment

When you delete a container all information is deleted incluide command history. The next configuration provides you an option for save the command history in your local environment and load it when you run a new container. So, you wont lose your command history when run a new container.

To use both options you should use -v option to map local directoty with /pentest container directory.

#### Option 1 - Command history using github repository

Add the next line in step "Create shorcuts" in Dockerfile, build a new image and run a new container.

    # Save and load command history in your local environment
    RUN sed -i '1i export HISTFILE="/pentest/.zsh_history"' /root/.zshrc

#### Option 2 - Command history using docker hub image

Create a new Dockerfile with the next steps, build a new image and run a new container.

    FROM aaaguirrep/pentest

    # Save and load command history in your local environment
    RUN sed -i '1i export HISTFILE="/pentest/.zsh_history"' /root/.zshrc

## :heavy_check_mark: Environment tested

The image was tested in the following environments:

- Docker service for Mac: Docker version 19.03.5, build 633a0ea

- Docker service for Linux instance on Google Cloud Platform: Docker version 19.03.6, build 369ce74a3c

## :warning: Warning

Do not save information on container directories because it will be lost after delete the container, you should save information in your local environment using the parameter -v when you run the container. For instance:

    docker run --rm -it -v /path/to/local/directory:/pentest --name my-pentest aaaguirrep/pentest /bin/zsh

The above command specify a path local directory mapped with /pentest container directory. You should save all information under /pentest directory.

## Contributing

[Contributing Guide](CONTRIBUTING.md)

## License

[MIT](LICENSE)

Copyright (c) 2020, Arsenio Aguirre
