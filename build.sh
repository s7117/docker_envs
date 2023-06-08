#!/bin/bash

echo "### LOG --> INIT build environment..."

# Create docker build environment
docker buildx create --name ubuntu_envs --use

echo "### LOG --> Created build environment..."

# Base
echo "### LOG --> BUILDING BASE IMAGE..."
docker buildx build -f ./base/Dockerfile --no-cache --platform=linux/amd64,linux/arm64 --push base --tag s7117/ubuntu_base:latest

echo "### LOG --> Base image built..."

# CUDA
echo "### LOG --> BUILDING CUDA IMAGES..."
docker buildx build -f ./cuda/11.7/Dockerfile --no-cache --platform=linux/amd64 --push cuda --tag s7117/ubuntu_cuda:11.7
docker buildx build -f ./cuda/11.8/Dockerfile --no-cache --platform=linux/amd64 --push cuda --tag s7117/ubuntu_cuda:11.8
docker buildx build -f ./cuda/12.1/Dockerfile --no-cache --platform=linux/amd64 --push cuda --tag s7117/ubuntu_cuda:12.1

echo "### LOG --> CUDA images built..."

# ML
echo "### LOG --> BUILDING ML IMAGES..."
docker buildx build -f ./ml/11.7/Dockerfile --no-cache --platform=linux/amd64 --push ml --tag s7117/ubuntu_ml:11.7
docker buildx build -f ./ml/11.8/Dockerfile --no-cache --platform=linux/amd64 --push ml --tag s7117/ubuntu_ml:11.8
docker buildx build -f ./ml/12.1/Dockerfile --no-cache --platform=linux/amd64 --push ml --tag s7117/ubuntu_ml:12.1

echo "### LOG --> ML images built..."

# Minecraft
# TODO

# OpenVINO
# FIXME
# docker buildx build --no-cache --tag s7117/ubuntu_openvino:latest --platform=linux/amd64,linux/arm64 --push openvino

# Cleanup build environment
docker buildx rm ubuntu_envs