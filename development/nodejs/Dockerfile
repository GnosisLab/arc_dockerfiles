FROM node:lts-bullseye

RUN \
  apt-get update && \
  apt-get -y --quiet --no-install-recommends install \
  build-essential \
  curl \
  git \
  locales \
  vim \
  wget \
  zsh \
  # Prevent apt-get cache from being persisted to this layer.
  && rm -rf /var/lib/apt/lists/*

RUN \
  ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.utf8


# install npm dependency
RUN \
  npm install --global \
  eslint \
  eslint-plugin-react-hooks \
  prettier

USER 1000
RUN curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -
CMD [ "zsh" ]
