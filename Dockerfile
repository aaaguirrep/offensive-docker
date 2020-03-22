FROM ubuntu

LABEL maintainer="Arsenio Aguirre"
LABEL email="a_aguirre117@hotmail.com"

# Install packages
RUN \
    apt-get update && \
    apt-get install -y \
    traceroute \
    net-tools \
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
    netcat \
    cewl \
    # evil-winrm
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
WORKDIR /tools/enum
RUN git clone https://github.com/m8r0wn/nullinux

# Install impacket
WORKDIR /tools
RUN git clone --depth 1 https://github.com/SecureAuthCorp/impacket.git
WORKDIR /tools/impacket
RUN pip3 install .

# Install ldapdomaindump
WORKDIR /tools
RUN git clone --depth 1 https://github.com/dirkjanm/ldapdomaindump.git
WORKDIR /tools/ldapdomaindump
RUN python3 setup.py install

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
WORKDIR /tools
RUN git clone --depth 1 https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git

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
RUN wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
RUN wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
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
RUN git clone --depth 1 https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git
WORKDIR /tools/exploits/Windows-Exploit-Suggester
RUN python windows-exploit-suggester.py --update
WORKDIR /tools/exploits
RUN git clone --depth 1 https://github.com/ohpe/juicy-potato.git

# Create shortcuts
RUN echo "alias squidUp=\"service squid start\"" >> /root/.zshrc
RUN echo "alias squidDwUp=\"service squid restart\"" >> /root/.zshrc
RUN echo "alias squidDown=\"service squid stop\"" >> /root/.zshrc
RUN echo "alias apacheUp=\"service apache2 start\"" >> /root/.zshrc
RUN echo "alias apacheDwUp=\"service apache2 restart\"" >> /root/.zshrc
RUN echo "alias apacheDown=\"service apache2 stop\"" >> /root/.zshrc

# Copy custom scripts
RUN mkdir -p /tools/scripts
COPY /customScripts/ /tools/scripts
WORKDIR /tools/scripts
RUN chmod +x *

# Copy custom function
COPY customFunctions /tmp
RUN cat /tmp/customFunctions >> /root/.zshrc

# Create or update a database used by locate
RUN updatedb

# Change workdir
WORKDIR /