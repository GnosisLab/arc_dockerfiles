#!/bin/bash

TAG=0.1
REPO=gnosislab/arc

echo "> CPU build"
BASE=ubuntu:20.04
docker build . -t $REPO:$TAG --build-arg BASE=$BASE

echo "> GPU build"
BASE=nvidia/cuda:11.2.0-cudnn8-runtime-ubuntu20.04
docker build . -t $REPO:$TAG-gpu --build-arg BASE=$BASE
