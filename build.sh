#!/bin/bash

# Fail fast
set -e

# This is the order of arguments
aws_ecr_repository_url_with_tag=$1

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

eval $( aws ecr get-login --no-include-email --region ap-south-1 )

# Build image
docker build -t $aws_ecr_repository_url_with_tag .

# Push image
docker push $aws_ecr_repository_url_with_tag
