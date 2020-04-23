FROM ubuntu as baseline

LABEL maintainer="Arsenio Aguirre"
LABEL email="a_aguirre117@hotmail.com"

# Install packages
RUN \
    apt-get update && \
    apt-get install -y \
    traceroute \
    whois \
    host \
    net-tools \
    figlet \
    tcpdump \
    telnet \
    prips \
    cifs-utils \
    rlwrap \
    iputils-ping \
    git \
    xsltproc \
    rdate \
    zsh \
    curl \
    unzip \
    p7zip-full \
    locate \
    openvpn \
    vim \
    wget \
    ftp \
    apache2 \
    squid \
    python3 \
    python \
    python-pip \
    python-dnspython \
    python3-pip \
    jq \
    libcurl4-openssl-dev \
    libssl-dev \
    nmap \
    masscan \
    nikto \
    netcat \
    cewl \
    crunch \
    hydra \
    medusa \
    hashcat \
    libwww-perl \
    chromium-browser \
    # patator dependencies
    libmysqlclient-dev \
    # evil-winrm dependencies
    ruby-full \
    # enum4linux dependencies
    ldap-utils \
    smbclient \
    # john dependencies
    build-essential \
    libssl-dev \
    zlib1g-dev  \
    yasm \
    pkg-config \
    libgmp-dev \
    libpcap-dev \
    libbz2-dev \
    # crackmapexec dependencies
    libffi-dev \
    python-dev && \
    gem install \
    gpp-decrypt \
    addressable \
    wpscan \
    # Install evil-winrm
    evil-winrm && \
    apt-get update

FROM baseline as builder
# SERVICES

# Apache configuration
RUN sed -i 's/It works!/It works form container!/g' /var/www/html/index.html

# Squid configuration
RUN echo "http_access allow all" >> /etc/squid/squid.conf
RUN sed -i 's/http_access deny all/#http_access deny all/g' /etc/squid/squid.conf

# OS TOOLS

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN sed -i '1i export LC_CTYPE="C.UTF-8"' /root/.zshrc
RUN sed -i '2i export LC_ALL="C.UTF-8"' /root/.zshrc
RUN sed -i '3i export LANG="C.UTF-8"' /root/.zshrc
RUN sed -i '3i export LANGUAGE="C.UTF-8"' /root/.zshrc

# Install python dependencies
COPY requirements_pip3.txt /tmp
COPY requirements_pip.txt /tmp
RUN pip3 install -r /tmp/requirements_pip3.txt
RUN pip install -r /tmp/requirements_pip.txt

# DEVELOPER TOOLS

# Install go
WORKDIR /tmp
RUN wget -q https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O go.tar.gz
RUN tar -C /usr/local -xzf go.tar.gz
ENV PATH "$PATH:/usr/local/go/bin"

# PORT SCANNING
RUN mkdir -p /tools/portScanning
WORKDIR /tools/portScanning

# Download ScanPorts
RUN wget --quiet https://raw.githubusercontent.com/aaaguirrep/scanPorts/master/scanPorts.sh
RUN chmod +x *

# BUILDER RECON
FROM baseline as recon
RUN mkdir /temp
WORKDIR /temp/

# Download whatweb
RUN git clone --depth 1 https://github.com/urbanadventurer/WhatWeb.git

# Download wafw00f
RUN git clone --depth 1 https://github.com/EnableSecurity/wafw00f.git

# Install dirsearch
RUN git clone --depth 1 https://github.com/maurosoria/dirsearch.git

# Download arjun
RUN git clone --depth 1 https://github.com/s0md3v/Arjun.git

# Download joomscan
RUN git clone --depth 1 https://github.com/rezasp/joomscan.git

# Install massdns
RUN git clone --depth 1 https://github.com/blechschmidt/massdns.git

# Install striker
RUN git clone --depth 1 https://github.com/s0md3v/Striker.git

# Install Photon
RUN git clone --depth 1 https://github.com/s0md3v/Photon.git

# Download CMSeek
RUN git clone --depth 1 https://github.com/Tuhinshubhra/CMSeeK.git

# Download gowitness
RUN mkdir -p /temp/gowitness
WORKDIR /temp/gowitness
RUN wget --quiet https://github.com/sensepost/gowitness/releases/download/1.3.3/gowitness-linux-amd64 -O gowitness
RUN chmod +x gowitness

# Download findomain
RUN mkdir -p /temp/findomain
WORKDIR /temp/findomain
RUN wget --quiet https://github.com/Edu4rdSHL/findomain/releases/download/1.5.0/findomain-linux -O findomain
RUN chmod +x findomain

# Download subfinder
RUN mkdir -p /temp/subfinder
WORKDIR /temp/subfinder
RUN wget --quiet https://github.com/projectdiscovery/subfinder/releases/download/v2.3.2/subfinder-linux-amd64.tar
RUN tar -xvf subfinder-linux-amd64.tar && rm subfinder-linux-amd64.tar
RUN mv subfinder-linux-amd64 subfinder

# Download Sublist3r
WORKDIR /temp
RUN git clone --depth 1 https://github.com/aboul3la/Sublist3r.git

# RECON
FROM builder as builder2
COPY --from=recon /temp/ /tools/recon/
WORKDIR /tools/recon

# Install gobuster
RUN go get github.com/OJ/gobuster
RUN ln -s /root/go/bin/gobuster /usr/bin/gobuster

# Install gowitness
RUN ln -s /tools/recon/gowitness/gowitness /usr/bin/gowitness

# Install subjack
RUN go get github.com/haccer/subjack
RUN ln -s /root/go/bin/subjack /usr/bin/subjack

# Install aquatone
RUN wget --quiet https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip -O aquatone.zip
RUN unzip aquatone.zip -d aquatone && rm aquatone.zip
RUN ln -s /tools/recon/aquatone/aquatone /usr/bin/aquatone

# Install knock
RUN git clone --depth 1 https://github.com/guelfoweb/knock.git
WORKDIR /tools/recon/knock
RUN python setup.py install

# Install linkfinder
WORKDIR /tools/recon
RUN git clone --depth 1 https://github.com/GerbenJavado/LinkFinder.git
WORKDIR /tools/recon/LinkFinder
RUN python3 setup.py install
RUN pip3 install -r requirements.txt

# Install amass
WORKDIR /tools/recon
RUN wget --quiet https://github.com/OWASP/Amass/releases/download/v3.5.5/amass_v3.5.5_linux_amd64.zip -O amass.zip
RUN unzip amass.zip -d amass && rm amass.zip
RUN ln -s /tools/recon/amass/amass_v3.5.5_linux_amd64/amass /usr/bin/amass

# Install hakrevdns
RUN go get github.com/hakluke/hakrevdns
RUN ln -s /root/go/bin/hakrevdns /usr/bin/hakrevdns

# Install ffuf
RUN go get github.com/ffuf/ffuf
RUN ln -s /root/go/bin/ffuf /usr/bin/ffuf

# Install httprobe
RUN go get -u github.com/tomnomnom/httprobe
RUN ln -s /root/go/bin/httprobe /usr/bin/httprobe

# Install hakrawler
RUN go get github.com/hakluke/hakrawler
RUN ln -s /root/go/bin/hakrawler /usr/bin/hakrawler

# Install waybackurls
RUN go get github.com/tomnomnom/waybackurls
RUN ln -s /root/go/bin/waybackurls /usr/bin/waybackurls

# Download gospider
RUN go get -u github.com/jaeles-project/gospider
RUN ln -s /root/go/bin/gospider /usr/bin/gospider

# Download getJS
RUN go get github.com/003random/getJS
RUN ln -s /root/go/bin/getJS /usr/bin/getJS

# Install findomain
RUN ln -s /tools/recon/findomain/findomain /usr/bin/findomain

# BUILDER WORDLIST
FROM baseline as wordlist
RUN mkdir /temp
WORKDIR /temp

# Download wordlists
RUN git clone --depth 1 https://github.com/xmendez/wfuzz.git
RUN git clone --depth 1 https://github.com/danielmiessler/SecLists.git
RUN git clone --depth 1 https://github.com/fuzzdb-project/fuzzdb.git
RUN git clone --depth 1 https://github.com/daviddias/node-dirbuster.git
RUN git clone --depth 1 https://github.com/v0re/dirb.git
RUN curl -L -o rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

# WORDLIST
FROM builder2 as builder3
COPY --from=wordlist /temp/ /tools/wordlist/

# BUILDER GIT REPOSITORIES
FROM baseline as gitrepositories
RUN mkdir /temp
WORKDIR /temp

# Download gitGrabber
RUN git clone --depth 1 https://github.com/hisxo/gitGraber.git

# Install gitrob
RUN wget --quiet https://github.com/michenriksen/gitrob/releases/download/v2.0.0-beta/gitrob_linux_amd64_2.0.0-beta.zip -O gitrob.zip
RUN unzip gitrob.zip -d gitrob
RUN rm gitrob.zip

# Install gitleaks
RUN wget --quiet https://github.com/zricethezav/gitleaks/releases/download/v4.1.0/gitleaks-linux-amd64 -O gitleaks
RUN chmod +x gitleaks

# Download github-search
RUN git clone --depth 1 https://github.com/gwen001/github-search.git

# GIT REPOSITORIES
FROM builder3 as builder4
COPY --from=gitrepositories /temp/ /tools/gitRepositories/

# BUILDER OWASP
FROM baseline as owasp
RUN mkdir /temp
WORKDIR /temp

# Install sqlmap
RUN git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap

# Download XSStrike
RUN git clone --depth 1 https://github.com/s0md3v/XSStrike.git

# OWASP
FROM builder4 as builder5
COPY --from=owasp /temp/ /tools/owasp/

# BUILDER BRUTE FORCE
FROM baseline as bruteForce
RUN mkdir /temp
WORKDIR /temp

# Download crowbar
RUN git clone --depth 1 https://github.com/galkan/crowbar.git

# Download patator
RUN git clone --depth 1 https://github.com/lanjelot/patator.git

# BRUTE FORCE
FROM builder5 as builder6
COPY --from=bruteForce /temp/ /tools/bruteForce/

# CRACKING
RUN mkdir -p /tools/cracking
WORKDIR /tools/cracking

# Install john the ripper
RUN git clone --depth 1 https://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
WORKDIR /tools/cracking/john/src
RUN ./configure && make -s clean && make -sj4

# BUILDER OS ENUMERATION
FROM baseline as osEnumeration
RUN mkdir /temp
WORKDIR /temp

# Download htbenum
RUN git clone --depth 1 https://github.com/SolomonSklash/htbenum.git
WORKDIR /temp/htbenum
RUN chmod +x htbenum.sh
RUN ./htbenum.sh -u

# Download linux smart enumeration
WORKDIR /temp
RUN git clone --depth 1 https://github.com/diego-treitos/linux-smart-enumeration.git
WORKDIR /temp/linux-smart-enumeration
RUN chmod +x lse.sh

# Download linenum
WORKDIR /temp
RUN git clone --depth 1 https://github.com/rebootuser/LinEnum.git
WORKDIR /temp/LinEnum
RUN chmod +x LinEnum.sh

# Download enum4linux
WORKDIR /temp
RUN git clone --depth 1 https://github.com/portcullislabs/enum4linux.git

# Download PEASS - Privilege Escalation Awesome Scripts SUITE
RUN mkdir -p /temo/peass
WORKDIR /temp/peass
RUN wget -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/winPEAS/winPEASexe/winPEAS/bin/Obfuscated%20Releases/winPEASany.exe
RUN wget -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/winPEAS/winPEASexe/winPEAS/bin/Obfuscated%20Releases/winPEASx64.exe
RUN wget -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/winPEAS/winPEASexe/winPEAS/bin/Obfuscated%20Releases/winPEASx86.exe

# Install smbmap
WORKDIR /temp
RUN git clone --depth 1 https://github.com/ShawnDEvans/smbmap.git

# Download pspy
RUN mkdir -p /temp/pspy
WORKDIR /temp/pspy
RUN wget -q https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
RUN wget -q https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
RUN chmod +x *

# OS ENUMERATION
FROM builder6 as builder7
COPY --from=osEnumeration /temp/ /tools/osEnumeration/
WORKDIR /tools/osEnumeration

# Download Windows Exploit Suggester - Next Generation
RUN git clone --depth 1 https://github.com/bitsadmin/wesng.git
WORKDIR /tools/osEnumeration/wesng
RUN python3 wes.py --update

# BUILDER EXPLOITS
FROM baseline as exploits
RUN mkdir /temp
WORKDIR /temp

# Downlaod MS17-010
RUN git clone --depth 1 https://github.com/worawit/MS17-010.git

# Downlaod AutoBlue-MS17-010
RUN git clone --depth 1 https://github.com/3ndG4me/AutoBlue-MS17-010.git

# Download privexchange
RUN git clone --depth 1 https://github.com/dirkjanm/PrivExchange.git

# EXPLOITS
FROM builder7 as builder8
COPY --from=exploits /temp/ /tools/exploits/
WORKDIR /tools/exploits

# Install searchsploit
RUN git clone --depth 1 https://github.com/offensive-security/exploitdb.git /opt/exploitdb
RUN sed 's|path_array+=(.*)|path_array+=("/opt/exploitdb")|g' /opt/exploitdb/.searchsploit_rc > ~/.searchsploit_rc
RUN ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit

# Install metasploit
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
RUN msfupdate

# BUILDER WINDOWS
FROM baseline as windows
RUN mkdir /temp
WORKDIR /temp

# Download crackmapexec
RUN git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec

# Download Nishang
RUN git clone --depth 1 https://github.com/samratashok/nishang.git

# Download juicy-potato
RUN git clone --depth 1 https://github.com/ohpe/juicy-potato.git

# Download powersploit
RUN git clone --depth 1 https://github.com/PowerShellMafia/PowerSploit.git

# Download Pass-the-Hash
RUN git clone --depth 1 https://github.com/byt3bl33d3r/pth-toolkit.git

# Download Mimikatz
RUN wget --quiet https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200308-1/mimikatz_trunk.zip -O mimikatz.zip
RUN unzip mimikatz.zip -d mimikatz
RUN rm mimikatz.zip

# WINDOWS
FROM builder8 as builder9
RUN mkdir -p /tools/windows
COPY --from=windows /temp/ /tools/windows/

# OTHER RESOURCES
RUN mkdir -p /tools/otherResources
WORKDIR /tools/otherResources

# Download pentest-tools
RUN git clone --depth 1 https://github.com/gwen001/pentest-tools.git

# Download qsreplace
RUN go get -u github.com/tomnomnom/qsreplace
RUN ln -s /root/go/bin/qsreplace /usr/bin/qsreplace

# OS TUNNING

# Copy banner
COPY shell/banner /tmp
RUN cat /tmp/banner >> /root/.zshrc

# Create shortcuts
COPY shell/alias /tmp
RUN cat /tmp/alias >> /root/.zshrc

# Copy custom function
COPY shell/customFunctions /tmp
RUN cat /tmp/customFunctions >> /root/.zshrc

# Create or update a database used by locate
RUN updatedb

# Change workdir
WORKDIR /