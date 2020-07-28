import sys
import os
import time

from download import FileDownloader
from processing import TesseractProcessor

def parse_arguments(argv):
    length = len(argv)
    return {
        "offset": int(argv[1]) if length > 1 else 1,
        "count": int(argv[0]) if length > 0 else 108953,
        "cache_dir": str(argv[2]) if length > 2 else "./verser",
        "result_dir": str(argv[3]) if length > 3 else "./verser"
    }

args = parse_arguments([sys.argv[i] for i in range(1, len(sys.argv))])

url_format = "https://hosting.softagent.se/upps-personverser/PictureLoader?Antialias=ON&ImageId=%s&Scale=1"
cache_dir = args["cache_dir"]
result_dir = args["result_dir"]
path_format = cache_dir + "/%s.jpg"
result_path_format = result_dir + "/%s.txt"
os.makedirs(cache_dir, exist_ok=True)
os.makedirs(result_dir, exist_ok=True)
processors = [
    TesseractProcessor(
        "swe",
        lambda id: result_path_format % id
    )
]
downloader = FileDownloader.from_array_ids(
    range(args["offset"], args["offset"] + args["count"]),
    lambda id: url_format % id,
    lambda id: path_format % id
)

for file in [downloader.file(file_id) for file_id in downloader.list_files()]:
    image = file.load()
    for processor in processors:
        try:
            processor.process(image, file.id)
            print("processed: %s" % (file.path))
        except KeyboardInterrupt:
            raise
        except:
            print("failed process: %s" % (file.path))