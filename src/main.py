import sys
import os
import time

from download import FileDownloader

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