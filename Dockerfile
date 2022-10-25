FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y net-tools \
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

CMD echo 'hello~~'
