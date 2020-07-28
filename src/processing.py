from PIL import Image
from typing import Callable
import pytesseract

class TesseractProcessor:
    def __init__(self, lang: str, gen_path: str):
        self.lang = lang
        self.gen_path = gen_path
    
    def process(self, image: Image, id: str):
        path = self.gen_path(id)
        result = pytesseract.image_to_string(image, lang = self.lang)
        with open(path, 'w') as f:
            f.write(result)

