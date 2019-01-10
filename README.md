# Processing of Personverser from the UUB archive

## Prerequisites
* ruby
* curl
* octave / matlab - with image processing toolbox
* tesseract ocr - with language packs

## Setup
### Debian

Run `sudo apt-get install ruby curl octave liboctave-dev tesseract-ocr tesseract-ocr-swe tesseract-ocr-eng` to install the needed packages in debian.

Run `octave-cli` to enter the octave command line interface.

In octave-cli run `pkg -forge list` to list all the packages available in octave forge.

In octave-cli run `pkg install -forge general image` to download and install the required packages.

In octave-cl run `exit` to exit.
