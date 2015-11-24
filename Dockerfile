FROM ubuntu:14.04
MAINTAINER iblancasa <iblancasa [a] gmail.com> Version: 1.0


# Define default command
CMD ["bash"]

ENV DEBIAN_FRONTEND noninteractive

# Install basics
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git unzip wget apt-transport-https


# Adding repos
RUN add-apt-repository ppa:staticfloat/juliareleases -y
RUN add-apt-repository ppa:staticfloat/julia-deps -y


# Installing more things
RUN apt-get update
RUN apt-get install julia lua5.2 git python ruby golang npm nodejs -y


# Cloning files
RUN git clone --recursive https://github.com/iblancasa/DockerEO.git

# Installing dependences of Nodeo
RUN cd DockerEO/nodeo && npm install
