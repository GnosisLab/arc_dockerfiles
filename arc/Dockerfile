ARG root=ubuntu:20.04
FROM ${root}

ENV \
  LANG en_US.utf8

RUN \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y curl wget vim git build-essential locales && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias ${LANG} && \
  ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
  # Prevent apt-get cache from being persisted to this layer.
  rm -rf /var/lib/apt/lists/*

RUN \
  apt-get update -y && \
  apt-get install -y --no-install-recommends \
  libjpeg-dev \
  libleptonica-dev \
  libopenjp2-7-dev \
  libpng-dev \
  libtesseract-dev \
  libtiff-dev \
  openjdk-11-jdk-headless \
  python-is-python3 \
  python3-dev \
  python3-pip \
  tesseract-ocr && \
  rm -rf /var/lib/apt/lists/*

RUN \
  pip install --no-cache-dir --quiet --upgrade pip \
  flask \
  gunicorn \
  numpy==1.21.4 \
  opencv-contrib-python-headless==4.5.5.62 \
  PyMuPDF \
  tensorflow==2.7.0 \
  tqdm

CMD [ "bash" ]
