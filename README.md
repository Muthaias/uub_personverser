# Processing of Personverser from the UUB archive
## Notice!!
The current state of this project is far from complete and the general intention is to have a base which to use for further experimentation.
Thus the code quality and functionality may vary quite a bit.

There's no usage documentation so BEWARE that you are on your own.

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
