#!/bin/bash

echo " ######### Installing Packages #########"
sudo apt update -y
sudo apt install -y htop git curl wget make

echo " ######### Installing Docker and docker compose #########"
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
chmod +x /tmp/get-docker.sh
/tmp/get-docker.sh
sudo usermod -aG docker ubuntu
sudo /etc/init.d/docker start


docker run -d -p 80:80 nginx:latest
