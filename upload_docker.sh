#!/usr/bin/env bash

dockerpath=narothamsai/nginx-web-server:0.0.3

echo "Docker ID and Image: $dockerpath"
docker tag nginx-web-server:0.0.3 $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath
