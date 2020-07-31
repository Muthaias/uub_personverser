from PIL import Image
import pycurl
import functools
from io import BytesIO
from os import path

class CachableFile:
    def __init__(self, id: str, url: str, path: str):
        self.id = id
        self.url = url
        self.path = path

    def load(self):
        self.download()
        return Image.open(self.path)

    def download(self):
        c = pycurl.Curl()
        c.setopt(c.URL, self.url)
        if path.isfile(self.path):
            print("in cache: %s" % self.path)
        else:
            print("%s -> %s" % (self.url, self.path))
            with open(self.path, 'wb') as f:
                c.setopt(c.WRITEFUNCTION, f.write)
                c.perform()
                c.close()

class FileDownloader:
    def __init__(self, files: [CachableFile]):
        self._fileMap = {file.id:file for file in files}
        
    def list_files(self):
        return [id for id in self._fileMap]

    def file(self, id: str):
        return self._fileMap[id]
            

    @staticmethod
    def from_array_ids(ids: [str], gen_url, gen_path):
        files = [CachableFile(id, gen_url(id), gen_path(id)) for id in ids]
        return FileDownloader(files)

    @staticmethod
    def from_array(urls: [str], gen_path):
        files = [CachableFile(id, url, gen_path(url)) for url in urls]
        return FileDownloader(files)
