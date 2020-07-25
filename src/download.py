import pycurl
import functools
from io import BytesIO
from os import path
import sys
import os
import time

class CachableFile:
  def __init__(self, id: str, url: str, path: str):
    self.id = id
    self.url = url
    self.path = path

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

def parse_arguments(argv):
  length = len(argv)
  return {
    "offset": int(argv[1]) if length > 1 else 1,
    "count": int(argv[0]) if length > 0 else 108953,
    "cache_dir": str(argv[2]) if length > 2 else "./verser"
  }

args = parse_arguments([sys.argv[i] for i in range(1, len(sys.argv))])

url_format = "https://hosting.softagent.se/upps-personverser/PictureLoader?Antialias=ON&ImageId=%s&Scale=1"
cache_dir = args["cache_dir"]
path_format = cache_dir + "/%s.jpg"
os.makedirs(cache_dir, exist_ok=True)
downloader = FileDownloader.from_array_ids(
  range(args["offset"], args["offset"] + args["count"]),
  lambda id: url_format % id,
  lambda id: path_format % id
)

for file in [downloader.file(file_id) for file_id in downloader.list_files()]:
  file.download()