FROM ubuntu

RUN apt-get update && \
    apt-get -y install curl && \
    apt-get -y install ruby && \
    apt-get -y install octave liboctave-dev build-essential && \
    octave-cli --eval "pkg install -forge general image" && \
    apt-get install -y tesseract-ocr tesseract-ocr-swe tesseract-ocr-eng

COPY ./src/ /opt/

VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT [ "bash" ]