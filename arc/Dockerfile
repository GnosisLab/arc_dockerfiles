ARG BASE=ubuntu:latest

FROM $BASE
LABEL MAINTAINER='GnosisLab<sundar@gnosislab.in>'

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG en_US.utf8
RUN apt-get update \
  && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias ${LANG}

RUN apt-get update \
  && apt-get install --no-install-recommends -y git wget \
  openjdk-11-jdk-headless python3-dev python3-pip python-is-python3 \
  libjpeg-dev libpng-dev libopenjp2-7-dev libtiff-dev \
  libleptonica-dev libtesseract-dev tesseract-ocr \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip \
  numpy opencv-contrib-python-headless==4.5.5.62 tensorflow==2.7.0 \
  PyMuPDF flask gunicorn tqdm
