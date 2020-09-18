<!-- markdownlint-disable MD033 MD041 -->

<p align="center">
  <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker">
    <img
      alt="Offensive Docker"
      src="https://github.com/aaaguirrep/offensive-docker/blob/master/img/banner.jpg"
      width="600"
    />
  </a>
</p>
<br/>
<p align="center">
  <a href="https://github.com/aaaguirrep/offensive-docker"><img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/aaaguirrep/offensive-docker"></a>
  <a href="https://github.com/aaaguirrep/offensive-docker"><img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/aaaguirrep/offensive-docker"></a>
  <a href="https://github.com/aaaguirrep/offensive-docker"><img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/aaaguirrep/offensive-docker"></a>
    <a href="https://github.com/aaaguirrep/offensive-docker"><img alt="GitHub issues" src="https://img.shields.io/github/issues/aaaguirrep/offensive-docker"></a>
    <a href="https://github.com/aaaguirrep/offensive-docker/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/aaaguirrep/offensive-docker">
  <a href="https://github.com/aaaguirrep/offensive-docker/blob/master/LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/aaaguirrep/offensive-docker"></a>
</p>
<p align="center">
  <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker"><img alt="Docker Cloud Build Status" src="https://img.shields.io/docker/cloud/build/aaaguirrep/offensive-docker"></a>
  <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker"><img alt="Docker Automated build" src="https://img.shields.io/docker/automated/aaaguirrep/offensive-docker"></a>
    <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker"><img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/aaaguirrep/offensive-docker"></a>
  <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker"><img alt="Docker Image Size (latest by date)" src="https://img.shields.io/docker/image-size/aaaguirrep/offensive-docker"></a>
    <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker"><img alt="Docker Image Version (latest by date)" src="https://img.shields.io/docker/v/aaaguirrep/offensive-docker"></a>
    <a href="https://hub.docker.com/r/aaaguirrep/offensive-docker"><img alt="Docker Stars" src="https://img.shields.io/docker/stars/aaaguirrep/offensive-docker"></a>
</p>
<p align="center">
  <a href="https://discord.gg/2uBfu8E"><img alt="Discord" src="https://img.shields.io/discord/749093790676942888"></a>
</p>

Offensive Docker is an image with the more used tools to create an pentest environment easily and quickly.

:arrow_right: **Note:** Check out the next repo to know how to launch offensive docker in a VPS in Google Cloud Platform or Digital Ocean (free credit included). [Offensive Docker VPS](https://github.com/aaaguirrep/offensive-docker-vps)

### Table of Contents

- [Links](#links)
- [Features](#features)
- [Requirements](#requirements)
- [Tools installed](#tools-installed)
  - [Operative system tools](#operative-system-tools)
  - [Network tools](#network-tools)
  - [Developer tools](#developer-tools)
  - [:hocho: Offensive tools](#hocho-offensive-tools)
    - [Port scanning](#port-scanning)
    - [:mag: Recon](#mag-recon)
      - [Subdomains](#subdomains)
      - [Subdomain takeover](#subdomain-takeover)
      - [DNS Lookups](#dns-lookups)
      - [:camera: Screenshot](#camera-screenshot)
      - [:spider_web: Crawler](#spider_web-crawler)
      - [:file_folder: Search directories](#file_folder-search-directories)
      - [Fuzzer](#fuzzer)
      - [Web Scanning](#web-scanning)
      - [CMS](#cms)
      - [Search JS](#search-js)
    - [Wordlist](#wordlist)
    - [Git repositories](#git-repositories)
    - [OWASP](#owasp)
    - [:iphone: Mobile](#iphone-mobile)
    - [Brute force](#brute-force)
    - [Cracking](#cracking)
    - [OS Enumeration](#os-enumeration)
    - [Exploits](#exploits)
    - [Windows](#windows)
    - [Reverse shell](#reverse-shell)
    - [Other resources](#other-resources)
  - [Custom functions](#custom-functions)
  - [Other services](#other-services)
- [:memo: Documentation](#memo-documentation)
- [:hammer_and_wrench: Usage](#hammer_and_wrench-usage)
  - [Option 1 - Use the github repository](#option-1---use-the-github-repository)
  - [Option 2 - Use the image from docker hub](#option-2---use-the-image-from-docker-hub)
  - [Considerations to run the container](#considerations-to-run-the-container)
- [:gear: Nice configurations](#gear-nice-configurations)
  - [1. Configure credentials in the docker](#1-configure-credentials-in-the-docker)
  - [2. Alias to connect to HTB (Hack the Box) VPN](#2-alias-to-connect-to-htb-hack-the-box-vpn)
    - [Option 1 - HTB VPN using github repository](#option-1---htb-vpn-using-github-repository)
    - [Option 2 - HTB VPN using docker hub image](#option-2---htb-vpn-using-docker-hub-image)
  - [3. Save and load command history in your local environment](#3-save-and-load-command-history-in-your-local-environment)
    - [Option 1 - Command history using github repository](#option-1---command-history-using-github-repository)
    - [Option 2 - Command history using docker hub image](#option-2---command-history-using-docker-hub-image)
- [:white_check_mark: Environment tested](#white_check_mark-environment-tested)
- [:warning: Warning](#warning-warning)
- [:coffee: Donations](#coffee-donations)
- [Contributors](#contributors)
- [Contributing](#contributing)
- [:chart_with_upwards_trend: Stargazers over time](#chart_with_upwards_trend-stargazers-over-time)
- [License](#license)

## Links

- 🎬 Video: [Demos](https://asciinema.org/~aaaguirrep)
- 💬 Chat: [Discord](https://discord.gg/2uBfu8E)
- 🌟 [VPS Automation](https://github.com/aaaguirrep/offensive-docker-vps)
- 👉 [Advanced configurations](https://github.com/aaaguirrep/offensive-docker-custom)

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

## Requirements

- Docker service installed

## Tools installed

### Operative system tools

- rdate
- vim
- zsh
- oh-my-zsh
- locate
- cifs-utils
- htop
- tree
- [gotop](https://github.com/cjbassi/gotop)

### Network tools

- traceroute
- telnet
- net-tools
- iputils-ping
- tcpdump
- openvpn
- whois
- host
- prips
- dig

### Developer tools

- git
- curl
- wget
- ruby
- go
- python
- python-pip
- python3
- python3-pip
- php
- aws-cli
- [tojson](https://github.com/tomnomnom/hacks/tree/master/tojson)
- nodejs

### :hocho: Offensive tools

#### Port scanning

- [nmap](https://github.com/nmap/nmap)
- [masscan](https://github.com/robertdavidgraham/masscan)
- [ScanPorts](https://github.com/aaaguirrep/scanPorts) created by [@s4vitar](https://github.com/s4vitar) with some improvements
- [naabu](https://github.com/projectdiscovery/naabu)

#### :mag: Recon

##### Subdomains

- [Amass](https://github.com/OWASP/Amass)
- [GoBuster](https://github.com/OJ/gobuster)
- [Knock](https://github.com/guelfoweb/knock)
- [MassDNS](https://github.com/blechschmidt/massdns)
- [Altdns](https://github.com/infosec-au/altdns)
- [spyse](https://github.com/zeropwn/spyse.py)
- [Sublist3r](https://github.com/aboul3la/Sublist3r)
- [findomain](https://github.com/Edu4rdSHL/findomain)
- [subfinder](https://github.com/projectdiscovery/subfinder)
- [spiderfoot](https://github.com/smicallef/spiderfoot)
- [haktldextract](https://github.com/hakluke/haktldextract)

##### Subdomain takeover

- [subjack](https://github.com/haccer/subjack)
- [SubOver](https://github.com/Ice3man543/SubOver)
- [tko-subs](https://github.com/anshumanbh/tko-subs)
  
##### DNS Lookups

- [hakrevdns](https://github.com/hakluke/hakrevdns)

##### :camera: Screenshot

- [gowitness](https://github.com/sensepost/gowitness)
- [aquatone](https://github.com/michenriksen/aquatone)

##### :spider_web: Crawler

- [hakrawler](https://github.com/hakluke/hakrawler)
- [Photon](https://github.com/s0md3v/Photon)
- [gospider](https://github.com/jaeles-project/gospider)
- [gau](https://github.com/lc/gau)
- [otxurls](https://github.com/lc/otxurls)
- [waybackurls](https://github.com/tomnomnom/waybackurls)
  
##### :file_folder: Search directories

- [dirsearch](https://github.com/maurosoria/dirsearch)

##### Fuzzer

- [wfuzz](https://github.com/xmendez/wfuzz)
- [ffuf](https://github.com/ffuf/ffuf)

##### Web Scanning

- [whatweb](https://github.com/urbanadventurer/WhatWeb)
- [wafw00z](https://github.com/EnableSecurity/wafw00f)
- [nikto](https://github.com/sullo/nikto)
- [arjun](https://github.com/s0md3v/Arjun)
- [httprobe](https://github.com/tomnomnom/httprobe)
- [striker](https://github.com/s0md3v/Striker)
- [hakcheckurl](https://github.com/hakluke/hakcheckurl)
- [httpx](https://github.com/projectdiscovery/httpx)

##### CMS

- [wpscan](https://github.com/wpscanteam/wpscan)
- [joomscan](https://github.com/rezasp/joomscan)
- [droopescan](https://github.com/droope/droopescan)
- [cmseek](https://github.com/Tuhinshubhra/CMSeeK)

##### Search JS

- [LinkFinder](https://github.com/GerbenJavado/LinkFinder)
- [getJS](https://github.com/003random/getJS)
- [subjs](https://github.com/lc/subjs)

#### Wordlist

- [cewl](https://github.com/digininja/CeWL)
- wordlists:
  - [wfuzz](https://github.com/xmendez/wfuzz)
  - [SecList](https://github.com/danielmiessler/SecLists)
  - [Fuzzdb](https://github.com/fuzzdb-project/fuzzdb)
  - [Dirbuster](https://github.com/daviddias/node-dirbuster)
  - [Dirb](https://github.com/v0re/dirb)
  - [Rockyou](https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt)
  - [all.txt](https://gist.github.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a)
- crunch

#### Git repositories

- [gitleaks](https://github.com/zricethezav/gitleaks)
- [gitrob](https://github.com/michenriksen/gitrob)
- [gitGraber](https://github.com/hisxo/gitGraber)
- [github-search](https://github.com/gwen001/github-search)
- [GitTools](https://github.com/internetwache/GitTools)

#### OWASP

- [sqlmap](https://github.com/sqlmapproject/sqlmap)
- [XSStrike](https://github.com/s0md3v/XSStrike)
- [kxss](https://github.com/tomnomnom/hacks/tree/master/kxss)
- [dalfox](https://github.com/hahwul/dalfox)
- [jwt_tool](https://github.com/ticarpi/jwt_tool)
- [jaeles](https://github.com/jaeles-project/jaeles)

#### :iphone: Mobile

- [apktool](https://ibotpeaches.github.io/Apktool/)

#### Brute force

- [crowbar](https://github.com/galkan/crowbar)
- [hydra](https://github.com/vanhauser-thc/thc-hydra)
- [patator](https://github.com/lanjelot/patator)
- medusa

#### Cracking

- [hashid](https://github.com/psypanda/hashID)
- [john the ripper](https://github.com/magnumripper/JohnTheRipper)
- [hashcat](https://github.com/hashcat/hashcat)

#### OS Enumeration

- [htbenum](https://github.com/SolomonSklash/htbenum)
- [linux-smart-enumeration](https://github.com/diego-treitos/linux-smart-enumeration)
- [linenum](https://github.com/rebootuser/LinEnum)
- [enum4linux](https://github.com/portcullislabs/enum4linux)
- [ldapdomaindump](https://github.com/dirkjanm/ldapdomaindump)
- [PEASS - Privilege Escalation Awesome Scripts SUITE](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite)
- [Windows Exploit Suggester - Next Generation](https://github.com/bitsadmin/wesng)
- [smbmap](https://github.com/ShawnDEvans/smbmap)
- [pspy - unprivileged Linux process snooping](https://github.com/DominicBreuker/pspy)
- smbclient
- ftp

#### Exploits

- [searchsploit](https://github.com/offensive-security/exploitdb)
- [Metasploit](https://github.com/rapid7/metasploit-framework)
- [MS17-010](https://github.com/worawit/MS17-010)
- [AutoBlue-MS17-010](https://github.com/3ndG4me/AutoBlue-MS17-010)
- [PrivExchange](https://github.com/dirkjanm/PrivExchange)

#### Windows

- [evil-winrm](https://github.com/Hackplayers/evil-winrm)
- [impacket](https://github.com/SecureAuthCorp/impacket)
- [CrackMapExec](https://github.com/byt3bl33d3r/CrackMapExec)
- [Nishang](https://github.com/samratashok/nishang)
- [Juicy Potato](https://github.com/ohpe/juicy-potato)
- [PowerSploit](https://github.com/PowerShellMafia/PowerSploit)
- [pass-the-hash](https://github.com/byt3bl33d3r/pth-toolkit)
- [mimikatz](https://github.com/gentilkiwi/mimikatz)
- gpp-decrypt

#### Reverse shell

- [netcat](https://github.com/diegocr/netcat)
- [rlwrap](https://github.com/hanslub42/rlwrap)

#### Other resources

- [pentest-tools](https://github.com/gwen001/offensive-tools) from [@gwen001](https://github.com/gwen001)
- [qsreplace](https://github.com/tomnomnom/qsreplace) from [@tomnomnom](https://github.com/tomnomnom)

### Custom functions

- NmapExtractPorts from [@s4vitar](https://github.com/s4vitar)

### Other services

- apache2
- squid

## :memo: Documentation

See the project's [wiki](https://github.com/aaaguirrep/offensive-docker/wiki) for documentation.

## :hammer_and_wrench: Usage

You can use the docker image by the next two options:

### Option 1 - Use the github repository

    git clone --depth 1 https://github.com/aaaguirrep/offensive-docker.git
    cd offensive-docker
    docker build -t offensive-docker .
    docker run --rm -it --name my-offensive-docker offensive-docker /bin/zsh

### Option 2 - Use the image from docker hub

Use image from docker hub: [aaaguirrep/offensive-docker](https://hub.docker.com/r/aaaguirrep/offensive-docker)

    docker pull aaaguirrep/offensive-docker
    docker run --rm -it --name my-offensive-docker aaaguirrep/offensive-docker /bin/zsh

### Considerations to run the container

There are differents use cases for use the image and you should know how to run the container properly.

1. Use the container to access HTB (Hack the Box) machines by HTB vpn.

        docker run --rm -it --cap-add=NET_ADMIN --device=/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --name my-offensive-docker aaaguirrep/offensive-docker /bin/zsh

2. Share information from your local directory to container directory and save information on your local directory. You should save information under /offensive directory.

        docker run --rm -it -v /path/to/local/directory:/offensive --name my-offensive-docker aaaguirrep/offensive-docker /bin/zsh

3. Expose internal container services (apache, squid) for your local environment.

        docker run --rm -it --name my-offensive-docker -p 80:80 -p 3128:3128 aaaguirrep/offensive-docker /bin/zsh

    Inside the container start apache2 and squid services by the aliases.

        apacheUp
        squidUp

4. Mount directories by umount command.

        docker run --rm -it --privileged --name my-offensive-docker aaaguirrep/offensive-docker /bin/zsh

5. Tools are downloaded in /tools directory.

## :gear: Nice configurations

You can set up the docker image with nice configurations like as:

### 1. Configure credentials in the docker

To use access keys, tokens or API Keys in the docker review the next repo [Offensive Docker Custom](https://github.com/aaaguirrep/offensive-docker-custom)

### 2. Alias to connect to HTB (Hack the Box) VPN

To use both options you should use -v option to map local directoty with /offensive container directory.

#### Option 1 - HTB VPN using github repository

Add the next line in step "Create shorcuts" in Dockerfile, build a new image and run a new container with the -v option.

    RUN echo "alias vpnhtb=\"openvpn /offensive/path/to/ovpn/file\"" >> /root/.zshrc

#### Option 2 - HTB VPN using docker hub image

Create a new Dockerfile with the next steps, build a new image and run a new container with -v option.

    FROM aaaguirrep/offensive-docker

    # Create a shortcut and load the ovpn file from workstation
    RUN echo "alias vpnhtb=\"openvpn /offensive/path/to/ovpn/file\"" >> /root/.zshrc

### 3. Save and load command history in your local environment

When you delete a container all information is deleted incluide command history. The next configuration provides you an option for save the command history in your local environment and load it when you run a new container. So, you wont lose your command history when run a new container.

To use both options you should use -v option to map local directoty with /offensive container directory.

#### Option 1 - Command history using github repository

Add the next line in step "Create shorcuts" in Dockerfile, build a new image and run a new container.

    # Save and load command history in your local environment
    RUN sed -i '1i export HISTFILE="/history/.zsh_history"' /root/.zshrc

#### Option 2 - Command history using docker hub image

Create a new Dockerfile with the next steps, build a new image and run a new container.

    FROM aaaguirrep/offensive-docker

    # Save and load command history in your local environment
    RUN sed -i '1i export HISTFILE="/history/.zsh_history"' /root/.zshrc

## :white_check_mark: Environment tested

The image was tested in the following environments:

- Docker service for Mac: Docker version 19.03.5, build 633a0ea

- Docker service for Linux instance on Google Cloud Platform: Docker version 19.03.6, build 369ce74a3c

- Docker service for Linux droplet on Digital Ocean: Docker version 19.03.6, build 369ce74a3c

## :warning: Warning

- Do not save information on container directories because it will be lost after delete the container, you should save information in your local environment using the parameter -v when you run the container. For instance:

      docker run --rm -it -v /path/to/local/directory:/offensive --name my-offensive-docker aaaguirrep/offensive-docker /bin/zsh

  The above command specify a path local directory mapped with /offensive container directory. You should save all information under /offensive directory.

- Use hashcat and john the ripper on controlled environments as CTF. You can experiment issues.

## :coffee: Donations

Thanks for your donations, are always appreciated.

While I drink the coffee I check more tools to add in the docker image.

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/aaaguirrep)

## Contributors

Thank you to all our [contributors](https://github.com/aaaguirrep/offensive-docker/graphs/contributors)!

## Contributing

[Contributing Guide](CONTRIBUTING.md)

## :chart_with_upwards_trend: Stargazers over time

[![Stargazers over time](https://starchart.cc/aaaguirrep/offensive-docker.svg)](https://starchart.cc/aaaguirrep/offensive-docker)

## License

[MIT](LICENSE)

Copyright (c) 2020, Arsenio Aguirre
