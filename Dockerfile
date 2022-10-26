FROM ubuntu:20.04

ENV TZ=Asia/Taipei

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

RUN apt-get install -y ca-certificates \
    gnupg \
    lsb-release &&
    mkdir -p /etc/apt/keyrings && 
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \ 
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli docker-compose-plugin 

CMD ["bash"]

