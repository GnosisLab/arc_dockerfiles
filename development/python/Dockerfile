# python developement docker
# Heavily inspired from 
# https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile

FROM nvidia/cuda:11.2.0-cudnn8-runtime-ubuntu20.04

ENV \
  LANG en_US.utf8

ARG USER="vscode"
ARG UID="1000"
ARG GID="1000"
ARG HOME="/home/${USER}"

RUN \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y sudo zsh curl wget vim git build-essential locales && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias ${LANG} && \
  ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
  curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
  useradd -m -s /bin/zsh -N -u $UID $USER && \
  chmod g+w /etc/passwd && \
  echo "${USER}    ALL=(ALL)    NOPASSWD:    ALL" >> /etc/sudoers && \
  chown -R ${UID}:${GID} ${HOME} && \
  # Prevent apt-get cache from being persisted to this layer.
  rm -rf /var/lib/apt/lists/*

# system library pre-requisites
RUN \
  apt-get update --yes && \
  apt-get install -y --no-install-recommends \
  autoconf \
  automake \
  fonts-dejavu \
  libjpeg-dev \
  libleptonica-dev \
  libopenjp2-7-dev \
  libpng-dev \
  libtesseract-dev \
  libtiff-dev \
  libtool \
  nodejs \
  openjdk-11-jdk-headless \
  pkg-config \
  python-is-python3 \
  python3-dev \
  python3-pip \
  tesseract-ocr \
  zlib1g-dev && \
  rm -rf /var/lib/apt/lists/*

# install python and it's library
RUN \
  python3 -m pip install --no-cache-dir --quiet --upgrade pip \
  flask \
  flatbuffers==1.12 \
  gunicorn \
  isort \
  jupyterlab \
  jupyterlab_code_formatter \
  matplotlib \
  notebook \
  numpy==1.21.4 \
  onnxruntime-gpu \
  opencv-contrib-python-headless==4.5.5.62 \
  openpyxl \
  pandas==1.3.4 \
  Pillow==8.4.0 \
  pylint \
  PyMuPDF \
  scikit-image==0.19.1 \
  scikit-learn==1.0.2 \
  scipy==1.7.3 \
  seaborn \
  tensorflow-datasets==4.4.0 \
  tensorflow==2.7.0 \
  tf2onnx \
  tqdm \
  xeus-python \
  yapf

# install npm dependency
RUN \
  npm install --global \
  prettier

# Setup $UID's home directory
USER $UID
ENV \
  SHELL=/bin/zsh \
  USER=$USER \
  UID=$UID \
  GID=$GID \
  HOME=/home/$USER
WORKDIR $HOME

# configure oh-my-zsh
RUN \
  curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -

CMD [ "zsh" ]
