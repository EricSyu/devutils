FROM ubuntu:20.04

ENV TZ=Asia/Taipei
WORKDIR /home_tmp
COPY . .

# netutils
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools \
	tcpdump \
    vim \
	iperf3 \
	iftop \
	ethtool \
	netcat \
    iputils-ping \
    wget \
    curl \
    iproute2 \
    redis-tools \
    dnsutils \
    telnet \
    git

# docker
RUN apt-get install -y ca-certificates \
    gnupg \
    lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \ 
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli docker-compose-plugin 

# kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# zsh
# p10k/tmux
ENV LC_ALL=en_US.UTF-8
RUN apt-get install -y zsh locales unzip && \
    locale-gen en_US.UTF-8 && \
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh && \
    echo 'wait 5s for "git clone zplug"' ; sleep 5s && \
    mv ~/.zplug . && \
    wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip -O exa-linux-x86_64-v0.10.1.zip && \
    unzip exa-linux-x86_64-v0.10.1.zip -d exa-linux-x86_64-v0.10.1 && \
    cp exa-linux-x86_64-v0.10.1/bin/exa /usr/local/bin/

# others
RUN apt-get install -y jq tree && \
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq && \
    wget https://github.com/antonmedv/fx/releases/latest/download/fx_linux_amd64 -O /usr/bin/fx && \
    chmod +x /usr/bin/fx

CMD cp -r .zshrc .p10k.zsh .zplug ~/. && \
    zsh
