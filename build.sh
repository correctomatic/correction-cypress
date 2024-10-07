#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <container-name>"
    exit 1
fi

# Rename .dockerignore to .dockerignore.disabled
mv .dockerignore .dockerignore.disabled

# Copy the dev .dockerignore to .dockerignore
cp .dockerignore.dev .dockerignore

# Build the image
docker build -f ./Dockerfile.correction -t $1 .


