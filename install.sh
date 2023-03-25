#!/bin/bash
set -e
ARCH="$(arch)"

if [ "$ARCH" != "aarch64" ]; then
	echo "This script is only for x86 not for ARM."
	exit 1
fi

echo "This will install Docker, docker compose and Portainer for Ubuntu/Debian based distros"
apt-get update && apt-get upgrade -y
apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt-cache policy docker-ce
apt-get -y install docker-ce -y
apt-get -y install docker-compose-plugin
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo ""
echo "Portainer is running on port 9443 through HTTPS."
