FROM ubuntu

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
    python3-pip \
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
    apt-get update
RUN gem install gpp-decrypt

# Apache configuration
RUN sed -i 's/It works!/It works form container!/g' /var/www/html/index.html

# Squid configuration
RUN echo "http_access allow all" >> /etc/squid/squid.conf
RUN sed -i 's/http_access deny all/#http_access deny all/g' /etc/squid/squid.conf

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN sed -i '1i export LC_CTYPE="C.UTF-8"' /root/.zshrc
RUN sed -i '2i export LC_ALL="C.UTF-8"' /root/.zshrc
RUN sed -i '3i export LANG="C.UTF-8"' /root/.zshrc
RUN sed -i '3i export LANGUAGE="C.UTF-8"' /root/.zshrc

# Copy banner
COPY shell/banner /tmp
RUN cat /tmp/banner >> /root/.zshrc

# Install python dependencies
COPY requirements_pip3.txt /tmp
COPY requirements_pip.txt /tmp
RUN pip3 install -r /tmp/requirements_pip3.txt
RUN pip install -r /tmp/requirements_pip.txt

# Download wordlists
RUN mkdir -p /tools/wordlist
WORKDIR /tools/wordlist
RUN git clone --depth 1 https://github.com/xmendez/wfuzz.git
RUN git clone --depth 1 https://github.com/danielmiessler/SecLists.git
RUN git clone --depth 1 https://github.com/fuzzdb-project/fuzzdb.git
RUN git clone --depth 1 https://github.com/daviddias/node-dirbuster.git
RUN git clone --depth 1 https://github.com/v0re/dirb.git

# Install searchsploit
RUN git clone --depth 1 https://github.com/offensive-security/exploitdb.git /opt/exploitdb
RUN sed 's|path_array+=(.*)|path_array+=("/opt/exploitdb")|g' /opt/exploitdb/.searchsploit_rc > ~/.searchsploit_rc
RUN ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit

# Install dirsearch
RUN mkdir -p /tools/recon
WORKDIR /tools/recon
RUN git clone --depth 1 https://github.com/maurosoria/dirsearch.git

# Install enum tools
RUN mkdir -p /tools/enum
WORKDIR /tools/enum
RUN git clone --depth 1 https://github.com/diego-treitos/linux-smart-enumeration.git
WORKDIR /tools/enum/linux-smart-enumeration
RUN chmod +x lse.sh
WORKDIR /tools/enum
RUN git clone --depth 1 https://github.com/rebootuser/LinEnum.git
WORKDIR /tools/enum/LinEnum
RUN chmod +x LinEnum.sh
WORKDIR /tools/enum
RUN git clone --depth 1 https://github.com/SolomonSklash/htbenum.git
WORKDIR /tools/enum/htbenum
RUN chmod +x htbenum.sh
RUN ./htbenum.sh -u
WORKDIR /tools/enum
RUN git clone --depth 1 https://github.com/portcullislabs/enum4linux.git

# Download rockyou dictionary
RUN mkdir -p /tools/dict
WORKDIR /tools/dict
RUN curl -L -o rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

# Install john the ripper
RUN mkdir -p /tools/cracking
WORKDIR /tools/cracking
RUN git clone --depth 1 https://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
WORKDIR /tools/cracking/john/src
RUN ./configure && make -s clean && make -sj4

# Download crowbar
WORKDIR /tools/cracking
RUN git clone --depth 1 https://github.com/galkan/crowbar.git

# Download patator
WORKDIR /tools/cracking
RUN git clone --depth 1 https://github.com/lanjelot/patator.git

# Download Pass-the-Hash
WORKDIR /tools/cracking
RUN git clone --depth 1 https://github.com/byt3bl33d3r/pth-toolkit.git

# Download Mimikatz
WORKDIR /tools/cracking
RUN wget --quiet https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200308-1/mimikatz_trunk.zip -O mimikatz.zip
RUN unzip mimikatz.zip
RUN rm mimikatz.zip

# Install evil-winrm
RUN gem install evil-winrm

# Install smbmap
WORKDIR /tools
RUN git clone --depth 1 https://github.com/ShawnDEvans/smbmap.git

# Install sqlmap
WORKDIR /tools
RUN git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

# Install crackmapexec
WORKDIR /tools
RUN git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
WORKDIR /tools/CrackMapExec
RUN pipenv install

# Download PEASS - Privilege Escalation Awesome Scripts SUITE
RUN mkdir -p /tools/PEASS
WORKDIR /tools/PEASS
RUN wget -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/winPEAS/winPEASexe/winPEAS/bin/Obfuscated%20Releases/winPEASany.exe
RUN wget -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/winPEAS/winPEASexe/winPEAS/bin/Obfuscated%20Releases/winPEASx64.exe
RUN wget -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/winPEAS/winPEASexe/winPEAS/bin/Obfuscated%20Releases/winPEASx86.exe

# Install metasploit
RUN mkdir -p /tools/metasploit
WORKDIR /tools/metasploit
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
RUN msfupdate

# Download pspy
RUN mkdir -p /tools/pspy
WORKDIR /tools/pspy
RUN wget -q https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
RUN wget -q https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
RUN chmod +x *

# Download exploits
RUN mkdir -p /tools/exploits
WORKDIR /tools/exploits
RUN git clone --depth 1 https://github.com/worawit/MS17-010.git
RUN git clone --depth 1 https://github.com/3ndG4me/AutoBlue-MS17-010.git
RUN git clone --depth 1 https://github.com/dirkjanm/PrivExchange.git
RUN git clone --depth 1 https://github.com/PowerShellMafia/PowerSploit.git
RUN git clone --depth 1 https://github.com/samratashok/nishang.git
RUN git clone --depth 1 https://github.com/bitsadmin/wesng.git
WORKDIR /tools/exploits/wesng
RUN python3 wes.py --update
WORKDIR /tools/exploits
RUN git clone --depth 1 https://github.com/ohpe/juicy-potato.git

# Passive Information tools (OSCP)
RUN mkdir -p /tools/Passive\ Information
WORKDIR /tools/Passive\ Information
RUN wget --quiet https://github.com/michenriksen/gitrob/releases/download/v2.0.0-beta/gitrob_linux_amd64_2.0.0-beta.zip -O gitrob.zip
RUN unzip gitrob.zip
RUN rm gitrob.zip
RUN wget --quiet https://github.com/zricethezav/gitleaks/releases/download/v4.1.0/gitleaks-linux-amd64 -O gitleaks
RUN chmod +x gitleaks

# Create shortcuts
COPY shell/alias /tmp
RUN cat /tmp/alias >> /root/.zshrc

# Copy custom scripts
RUN mkdir -p /tools/scripts
WORKDIR /tools/scripts
RUN wget --quiet https://raw.githubusercontent.com/aaaguirrep/scanPorts/master/scanPorts.sh
RUN chmod +x *

# Copy custom function
COPY shell/customFunctions /tmp
RUN cat /tmp/customFunctions >> /root/.zshrc

# Create or update a database used by locate
RUN updatedb

# Change workdir
WORKDIR /