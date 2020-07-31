import sys
import os
import time

from download import FileDownloader
from processing import TesseractProcessor, OctaveProcessor
from argument_parser import ArgumentParser

args = ArgumentParser.parse_argv(
    [
        ArgumentParser("offset", "-o", 1, 1, lambda params: int(params[0])),
        ArgumentParser("count", "-c", 1, 108953, lambda params: int(params[0])),
        ArgumentParser("cache_dir", "-cd", 1, "./verser", lambda params: params[0]),
        ArgumentParser("result_dir", "-rd", 1, "./verser", lambda params: params[0]),
        ArgumentParser("processor_id", "-p", 1, "ocr", lambda params: params[0])
    ],
    sys.argv[1:len(sys.argv)]
)

url_format = "https://hosting.softagent.se/upps-personverser/PictureLoader?Antialias=ON&ImageId=%s&Scale=1"
cache_dir = args["cache_dir"]
result_dir = args["result_dir"]
processor_id = args["processor_id"]
path_format = cache_dir + "/%s.jpg"
result_path_format = result_dir + "/%s.txt"
os.makedirs(cache_dir, exist_ok=True)
os.makedirs(result_dir, exist_ok=True)
all_processors = [
    TesseractProcessor(
        "swe",
        lambda id: result_path_format % id
    ),
    OctaveProcessor(
        os.path.dirname(os.path.abspath(__file__)),
        result_dir + "/__tmp.png",
        lambda id: (result_dir + "/%s.png") % id
    )
]
downloader = FileDownloader.from_array_ids(
    range(args["offset"], args["offset"] + args["count"]),
    lambda id: url_format % id,
    lambda id: path_format % id
)

for file in [downloader.file(file_id) for file_id in downloader.list_files()]:
    image = file.load()
    for processor in [p for p in all_processors if p.id == processor_id]:
        try:
            processor.process(image, file.id)
            print("processed: %s %s" % (processor.id, file.path))
        except KeyboardInterrupt:
            raise
        except:
            print("failed process: %s %s" % (processor.id, file.path))