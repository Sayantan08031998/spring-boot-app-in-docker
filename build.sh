#!/bin/bash

# Fail fast
set -e

# This is the order of arguments
aws_ecr_repository_url_with_tag=$1

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

# Build image
docker build -t $aws_ecr_repository_url_with_tag .

aws ecr get-login-password \
    --region ap-south-1 \
| docker login \
    --username AWS \
    --password-stdin 749266080072.dkr.ecr.ap-south-1.amazonaws.com

# Push image
docker push $aws_ecr_repository_url_with_tag

