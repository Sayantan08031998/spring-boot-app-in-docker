#!/bin/bash

# Fail fast
set -e

# This is the order of arguments
build_folder=$1
aws_ecr_repository_url_with_tag=$2

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

# Build image
docker build -t $aws_ecr_repository_url_with_tag $build_folder

# Push image
docker push $aws_ecr_repository_url_with_tag
