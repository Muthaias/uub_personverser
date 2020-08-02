FROM fedora

RUN dnf update -y && \
    dnf install python -y && \
    dnf groupinstall "Development Tools" "Development Libraries" -y && \
    dnf install octave octave-devel -y

RUN dnf install dnf-plugins-core -y && \
    dnf config-manager --add-repo https://download.opensuse.org/repositories/home:Alexander_Pozdnyakov/Fedora_30/home:Alexander_Pozdnyakov.repo && \
    dnf install tesseract -y && \
    dnf install tesseract-langpack-swe tesseract-langpack-eng -y

RUN octave-cli --eval "pkg install -forge general image"

RUN python -m pip install --upgrade pip setuptools wheel && \
    python -m pip install --compile --install-option="--with-openssl" pycurl && \
    python -m pip install pillow && \
    python -m pip install pytesseract

VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT [ "bash" ]