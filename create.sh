#!/bin/bash

# https://hub.docker.com/r/linuxserver/unifi/
# https://github.com/linuxserver/docker-unifi


# To pull latest: docker pull linuxserver/unifi
# Better success: 
#   1.  git clone https://github.com/linuxserver/docker-unifi.git
#   2.  Place this file within the cloned directory
#   3.  Run this file.





# Make the docker image, directing the resulting hash to a file
# for later reference.
TAG=unifivideo
docker build -t $TAG . 

# > ImageHash.txt

HOST_DIR=/var/ubnt/container-video

# Create the container
docker create \
  --name=unifivideo \
  -v $HOST_DIR/data:/var/lib/unifi-video \
  -v $HOST_DIR/logs:/var/log/unifi-video \
  -v $HOST_DIR/videos:/usr/lib/unifi-video/data/videos \
  -e PGID=1001 -e PUID=1001  \
  -e TZ=America/Chicago \
  -p 7443:7443 \
  -p 7080:7080 \
  -p 6666:6666 \
  -p 7445:7445 \
  -p 7446:7446 \
  -p 7447:7447 \
  --cap-add SYS_ADMIN \
  --cap-add DAC_READ_SEARCH \
  $TAG   #      > ContainerHash.txt



# Start the container.
docker start unifivideo
#docker run \
#  -p 8080:8080 \
#  -p 8081:8081 \
#  -p 8443:8443 \
#  -p 8843:8843 \
#  -p 8880:8880 \
#  --rm \
#  unifi

