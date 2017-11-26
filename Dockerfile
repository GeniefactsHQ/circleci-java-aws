FROM ubuntu:xenial

WORKDIR /root

# Install AWS CLI
RUN \
  apt-get update -y && \
	apt-get install -y python-dev python-pip && \
	pip install awscli --upgrade --user && \
  apt-get purge -y python-dev && apt autoremove -y && apt autoclean -y

# Define path for pip
ENV PATH=${PATH}:/root/.local/bin

# Install Java.
RUN \
  apt-get install -y software-properties-common python-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get purge -y software-properties-common python-software-properties && apt autoremove -y && apt autoclean -y

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Maven
RUN \
  wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz && \
  tar -xzvf apache-maven-3.5.2-bin.tar.gz -C /opt && \
  rm -rf apache-maven-3.5.2-bin.tar.gz

ENV M2_HOME=/opt/apache-maven-3.5.2
ENV PATH=${PATH}:$M2_HOME/bin

# Install Git
RUN \
  apt-get update && apt-get install -y git && \
  rm -rf /var/lib/apt/lists/*

# Install Docker
RUN \
  apt-get update && apt-get install -y curl lsb-release software-properties-common apt-transport-https && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
  apt-get update && \
  apt-get install -y docker-ce && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get purge -y curl lsb-release software-properties-common apt-transport-https && apt autoremove -y && apt autoclean -y
