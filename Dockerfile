# python developement docker
# Heavily inspired from 
# https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile

FROM nvidia/cuda:11.4.2-cudnn8-runtime-ubuntu20.04

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG USER="python3"
ARG UID="1000"
ARG GID="1000"

RUN \
  apt-get update \
  && apt-get install -y sudo zsh curl wget git build-essential \
  && useradd -m -s /bin/zsh -N -u $UID $USER \
  && chmod g+w /etc/passwd \
  && echo "${USER}    ALL=(ALL)    NOPASSWD:    ALL" >> /etc/sudoers \
  # Prevent apt-get cache from being persisted to this layer.
  && rm -rf /var/lib/apt/lists/*

RUN \
  # add nodejs support
  curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -

RUN \
  # system library pre-requisites
  apt-get update \
  && apt-get install -y --no-install-recommends \
  vim fonts-dejavu autoconf automake libtool pkg-config zlib1g-dev \
  openjdk-11-jdk-headless python3-dev python3-pip python-is-python3 nodejs \
  libjpeg-dev libpng-dev libopenjp2-7-dev libtiff-dev \
  libleptonica-dev libtesseract-dev tesseract-ocr \
  && rm -rf /var/lib/apt/lists/*

RUN \
  # install python and it's library
  python3 -m pip install --no-cache-dir --quiet --upgrade pip \
  ipykernel jupyter_kernel_gateway jupyterlab jupyterlab_code_formatter \ xeus-python numpy opencv-contrib-python-headless==4.5.4.60 Pillow \ tensorflow==2.7.0 scikit-learn scikit-image pandas spacy seaborn matplotlib \ PyMuPDF boto3 flask gunicorn pylint yapf isort tqdm openpyxl \
  && python -m ipykernel install --sys-prefix

# Setup the UID user with root privileges
USER $UID
ENV \
  SHELL=/bin/zsh \
  USER=$USER \
  UID=$UID \
  GID=$GID \
  HOME=/home/$USER

USER root
RUN chown -R ${UID}:${GID} ${HOME}

# Setup $UID's home directory
WORKDIR $HOME
USER $UID

ENV OH_MY_ZSH https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
ENV GUIDE https://raw.githubusercontent.com/GnosisLab/Coding_Guide/developement

RUN \
  # install oh-my-zsh
  curl -fsSL ${OH_MY_ZSH} | bash - \
  && wget -O ${HOME}/.editorconfig ${GUIDE}/editorconfig \
  && wget -O ${HOME}/.style.yapf ${GUIDE}/style.yapf \
  && wget -O ${HOME}/.pylintrc ${GUIDE}/pylintrc \
  && wget -O ${HOME}/.vimrc ${GUIDE}/vimrc
