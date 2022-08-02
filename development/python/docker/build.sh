#!/bin/bash
repo=gnosislab/python3:0.1

docker build . -t $repo
docker build . -t $repo-gpu \
  --build-arg root=nvidia/cuda:11.2.0-cudnn8-runtime-ubuntu20.04
