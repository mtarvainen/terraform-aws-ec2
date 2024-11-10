#!/bin/bash
sudo apt update
sudo apt -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    gpg

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker || echo "docker group exist"
sudo usermod -aG docker admin || echo "failed to set needed groups for admin user"
curl -sL https://deb.nodesource.com/setup_16.x | bash -
sudo apt install nodejs git nginx build-essential apache2-utils -y

