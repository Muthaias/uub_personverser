import os
from PIL import Image
from typing import Callable
import pytesseract

class TesseractProcessor:
    def __init__(self, lang: str, gen_path):
        self.lang = lang
        self.gen_path = gen_path
        self.id = "ocr"
    
    def process(self, image: Image, id: str):
        path = self.gen_path(id)
        result = pytesseract.image_to_string(image, lang = self.lang)
        with open(path, 'w') as f:
            f.write(result)

class OctaveProcessor:
    def __init__(self, code_root: str, tmp: str, gen_path):
        self.code_root = code_root
        self.tmp = tmp
        self.gen_path = gen_path
        self.id = "octave"

    def process(self, image: Image, id: str):
        path = self.gen_path(id)
        image.save(self.tmp)
        os.system("octave-cli -qf %s/octave/exec_fix.m %s %s" % (self.code_root, self.tmp, path))
