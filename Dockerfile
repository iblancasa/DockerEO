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
RUN echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823

# Installing languages
RUN apt-get update
RUN apt-get install julia lua5.2 git python ruby golang npm nodejs scala sbt -y


# Cloning files
RUN git clone --recursive https://github.com/iblancasa/DockerEO.git

# Compiling C/C++ version
RUN cd DockerEO/eo_revival/bfcpp && make

# Installing dependences of Nodeo
RUN cd DockerEO/nodeo && npm install

# Compiling Scala files
RUN cd DockerEO/scalEO && sbt compile
