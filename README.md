# Processing of Personverser from the UUB archive
## Notice!!
The current state of this project is far from complete and the general intention is to have a base which to use for further experimentation.
Thus the code quality and functionality may vary quite a bit.

There's no usage documentation so BEWARE that you are on your own.

## Prerequisites
* python
* octave / matlab - with image processing toolbox
* tesseract ocr - with language packs
* (podman / docker)

## Setup
### Fedora 32
```
sudo dnf update -y
sudo dnf install python -y
sudo dnf groupinstall "Development Tools" "Development Libraries" -y
sudo dnf install octave octave-devel -y

sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:Alexander_Pozdnyakov/Fedora_30/home:Alexander_Pozdnyakov.repo
sudo dnf install tesseract -y
sudo dnf install tesseract-langpack-swe tesseract-langpack-eng -y

sudo octave-cli --eval "pkg install -forge general image"

python -m pip install --upgrade pip setuptools wheel && \
python -m pip install --compile --install-option="--with-openssl" pycurl && \
python -m pip install pillow && \
python -m pip install pytesseract
```

### Simple setup
In order to simplify the setup you might want to use Podman or Docker. There's a Dockerfile based on Fedora 32 which handles the setup of dependencies. The file `build-container.sh` will build the container using Podman and the file `run-container.sh` will run the container and mount the development directory i.e. the directory containing the `run-container.sh` file.