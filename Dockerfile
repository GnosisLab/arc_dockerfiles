FROM ubuntu:20.04
LABEL MAINTAINER="GnosisLab<sundar@gnosislab.in>"
LABEL TAG="0.3" 

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y build-essential cmake pkg-config \
  libtool libtbb2 zlib1g-dev libfreetype6-dev libharfbuzz-dev libjbig2dec0-dev \
  libswscale-dev libjpeg-dev libpng-dev libopenjp2-7-dev libtiff-dev wget \
  openjdk-11-jdk-headless python3-dev python3-pip python-is-python3 libmupdf-dev vim

RUN pip install pip numpy==1.19.5 opencv-contrib-python-headless==4.5.2.54 \
  scikit-learn tensorflow==2.5.0 pandas matplotlib pygments==2.4.1 tqdm PyMuPDF \
  flask gunicorn

ENV PATH "$PATH:/sbt/bin"
RUN wget -c https://github.com/sbt/sbt/releases/download/v1.5.3/sbt-1.5.3.tgz && \
  tar xzf sbt-1.5.3.tgz && rm -rf sbt-1.5.3.tgz

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64.deb && \ 
  dpkg -i dumb-init_*.deb && rm -rf dumb-init_*.deb

RUN wget -c http://www.leptonica.org/source/leptonica-1.79.0.tar.gz -O - | tar xz && \
  cd leptonica-1.79.0 && ./configure && make -j`nproc` && make install && ldconfig && \
  cd .. && rm -rf leptonica-*

RUN wget -c https://github.com/tesseract-ocr/tesseract/archive/4.1.1.tar.gz -O - | tar xz && \
  cd tesseract-4.1.1 && ./autogen.sh && ./configure --prefix=/usr  && \
  make -j`nproc` && make install && ldconfig && \
  cd .. && rm -rf tesseract-*

ENV TESSDATA_PREFIX /usr/share/tessdata
ADD https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata ${TESSDATA_PREFIX}/
ADD https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata ${TESSDATA_PREFIX}/
RUN chmod -R 755 /usr/share/tessdata