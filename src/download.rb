require 'fileutils'
require_relative 'file-downloader'

if (ARGV.include?("--h") || ARGV.include?("-help"))
	puts "Image downloader for personverser @ UUB"
	puts " Usage: ruby download.rb [count|109853] [offset|1] [output_root_dir|./verser]"
	exit(0)
end

offset = ARGV.length > 1 ? ARGV[1].to_i(10) : 1
count = ARGV.length > 0 ? ARGV[0].to_i(10) : 108953
outpath_root = ARGV.length > 2 ? ARGV[2] : "./verser"

downloader = FileDownloader.from_array_ids(
	(1..108953),
	lambda {|num| "https://hosting.softagent.se/upps-personverser/PictureLoader?Antialias=ON&ImageId=#{num}&Scale=1"},
	lambda {|num| "#{outpath_root}/#{num}.jpg"}
)

FileUtils.mkdir_p(outpath_root)
fileIds = downloader.list_files
fileIds.each do |fileId|
	file = downloader.file(fileId)
	FileDownloader.download_entry(file)
end