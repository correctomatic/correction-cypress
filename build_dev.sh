#!/usr/bin/env bash

TAG=${1:-latest}

# Rename .dockerignore to .dockerignore.disabled
mv .dockerignore .dockerignore.disabled

# Copy the dev .dockerignore to .dockerignore
cp .dockerignore.dev .dockerignore

# Build the image
docker build -f ./Dockerfile.correction -t $1 .


