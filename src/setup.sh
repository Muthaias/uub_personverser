mkdir tessdata
cd tessdata
wget https://github.com/tesseract-ocr/tessdata/raw/master/swe.traineddata
export TESSDATA_PREFIX=$(pwd)