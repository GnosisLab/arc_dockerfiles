FROM nvidia/cuda:11.4.2-cudnn8-runtime-ubuntu20.04

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG NB_USER="python3"
ARG NB_UID="1000"
ARG NB_GID="1000"

# Setup the "python3" user with root privileges.
RUN \
  apt-get update && \
  apt-get install -y sudo zsh curl wget git build-essential && \
  useradd -m -s /bin/zsh -N -u $NB_UID $NB_USER && \
  chmod g+w /etc/passwd && \
  echo "${NB_USER}    ALL=(ALL)    NOPASSWD:    ALL" >> /etc/sudoers && \
  # Prevent apt-get cache from being persisted to this layer.
  rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Make the default shell zsh (vs "sh") for a better Jupyter terminal UX
ENV SHELL=/bin/zsh \
  NB_USER=$NB_USER \
  NB_UID=$NB_UID \
  NB_GID=$NB_GID \
  HOME=/home/$NB_USER

# Heavily inspired from https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile
USER root

# system library pre-requisites
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim fonts-dejavu autoconf automake libtool pkg-config \
  openjdk-11-jdk-headless python3-dev python3-pip python-is-python3 \
  zlib1g-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff-dev \
  libleptonica-dev libtesseract-dev && \
  rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
  apt-get update && apt-get install -y nodejs && \
  rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --quiet --upgrade pip \
  ipykernel jupyter_kernel_gateway jupyterlab jupyterlab_code_formatter xeus-python \
  numpy==1.19.5 opencv-contrib-python-headless==4.5.2.54 tensorflow==2.5.0 Pillow \
  scikit-learn scikit-image pandas spacy seaborn matplotlib PyMuPDF \
  boto3 flask gunicorn pylint yapf isort tqdm openpyxl && \
  python -m ipykernel install --sys-prefix

RUN chown -R ${NB_UID}:${NB_GID} ${HOME}

WORKDIR $HOME
USER $NB_UID

RUN curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -

ENV STYLE_GUIDE https://raw.githubusercontent.com/GnosisLab/Coding_Guide/developement/
RUN wget -O ${HOME}/.style.yapf ${STYLE_GUIDE}/style.yapf && \
  wget -O ${HOME}/.pylintrc ${STYLE_GUIDE}/pylintrc && \
  wget -O ${HOME}/.vimrc ${STYLE_GUIDE}/vimrc
