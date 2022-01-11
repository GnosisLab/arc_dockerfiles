#!/bin/bash

TAG=0.1
REPO=gnosislab/arc

CPU_BASE=ubuntu:20.04
GPU_BASE=nvidia/cuda:11.4.2-cudnn8-runtime-ubuntu20.04

echo ">>> CPU DOCKER"
docker build . -t $REPO:$TAG --build-arg BASE=$CPU_BASE

echo ">>> GPU DOCKER"
docker build . -t $REPO:$TAG-gpu --build-arg BASE=$GPU_BASE
