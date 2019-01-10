if (ARGV.include?("--h") || ARGV.include?("-help"))
	puts "Image downloader for personverser @ UUB"
	puts " Usage: ruby download.rb [count|109853] [offset|1] [output_root_dir|./verser]"
	exit(0)
end

def download_entries(offset, count, outpath_gen, address_gen)
	stop = offset + count - 1
	(offset..stop).each do |num|
		outpath = outpath_gen.call(num)
		address = address_gen.call(num)
		puts address
		data = `curl "#{address}" --output #{outpath}`
	end
end

offset = ARGV.length > 1 ? ARGV[1].to_i(10) : 1
count = ARGV.length > 0 ? ARGV[0].to_i(10) : 108953
output_root = ARGV.length > 2 ? ARGV[2] : "./verser"

outpath_gen = lambda {|num| "#{output_root}/#{num}.jpg"}
address_gen = lambda {|num| "https://deva.its.uu.se/upps-personverser/PictureLoader?Antialias=ON&ImageId=#{num}&Scale=1"}

download_entries(offset, count, outpath_gen, address_gen)
