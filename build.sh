#!/bin/bash

# Fail fast
set -e

# This is the order of arguments
aws_ecr_repository_url_with_tag=$1

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

# Build image
docker build -t $aws_ecr_repository_url_with_tag .

aws ecr get-login-password --no-include-email

# Push image
docker push $aws_ecr_repository_url_with_tag
