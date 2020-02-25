FROM ubuntu

LABEL maintainer="Arsenio Aguirre"
LABEL email="a_aguirre117@hotmail.com"

# Install packages
RUN \
    apt-get update && \
    apt-get install -y \
    traceroute \
    net-tools \
    iputils-ping \
    git \
    zsh \
    curl \
    locate \
    openvpn \
    vim \
    wget \
    ftp \
    apache2 \
    squid \
    python3 \
    python3-pip \
    libcurl4-openssl-dev \
    libssl-dev \
    nmap && \
    apt-get update

# Apache configuration
RUN sed -i 's/It works!/It works form container!/g' /var/www/html/index.html

# Squid configuration
RUN echo "http_access allow all" >> /etc/squid/squid.conf
RUN sed -i 's/http_access deny all/#http_access deny all/g' /etc/squid/squid.conf

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install python dependencies
RUN mkdir /installer
COPY requeriments.txt /installer
RUN pip3 install -r /installer/requirements.txt
RUN rm -rf /installer

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

# Create shortcuts
RUN echo "alias squidUp=\"service squid start\"" >> /root/.zshrc
RUN echo "alias squidDwUp=\"service squid restart\"" >> /root/.zshrc
RUN echo "alias squidDown=\"service squid stop\"" >> /root/.zshrc
RUN echo "alias apacheUp=\"service apache2 start\"" >> /root/.zshrc
RUN echo "alias apacheDwUp=\"service apache2 restart\"" >> /root/.zshrc
RUN echo "alias apacheDown=\"service apache2 stop\"" >> /root/.zshrc

# Create or update a database used by locate
RUN updatedb

# Change workdir
WORKDIR /