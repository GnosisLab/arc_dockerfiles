FROM ubuntu:20.04

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
  apt-get install -y --no-install-recommends nodejs && \
  rm -rf /var/lib/apt/lists/*

# install npm dependency
RUN \
  npm install --global \
  prettier eslint eslint-plugin-react-hooks

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
