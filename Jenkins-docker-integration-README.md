# Jenkins intergration with Docker

- Navigate to manage jenkins 
- install required plugins
   - openjdk
   - docker
      - docker
      - docker pipeline
      - docker build-setup
      - cloudbees docker build and push

Navigate to tools and install;
- openJDK --> #The versions required
     - #check box for install automatically
     - install from adoptium.net
- maven --> #The version required
- Docker --> #use latest version
     - #check box for install automatically
     - Downlod from docker.com
Apply and save

**ssh into your jenkins instance**

- Install docker

#!/bin/bash
#Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

#Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

- Add jenkins to the docker group

      sudo usermod -aG dokcer jenkins

- Restart jenkins when ever you add a user to docker
  group.

       sudo systemctl restart jenkins
