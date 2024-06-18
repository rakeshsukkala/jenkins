
Process -1 
install jenkins in ubuntu docker container

docker pull ubuntu:latest
docker run -it --name jenkins-ubuntu ubuntu:latest /bin/bash
apt-get update
apt-get install -y openjdk-11-jdk wget gnupg2
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins
exit
docker commit jenkins-ubuntu jenkins-ubuntu-image
docker run -d -p 8081:8081 --name jenkins-ubuntu jenkins-ubuntu-image


Process -2
docker compose file for jenkins

version: '3.8'
services:
  jenkins:
    image: jenkins/jenkins:lts
    privileged: true
    user: root
    ports:
     - 9090:8080
    container_name: jenkins
    build:
      context: jenkins
