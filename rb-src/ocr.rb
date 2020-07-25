if (ARGV.include?("--h") || ARGV.include?("-help"))
	puts "Tesseract OCR of png images:"
	puts " Usage: ruby ocr.rb [start|1] [stop|start] [lang|swe] [inpath_root|./fix_verser] [outpath_root|./fix_texter]"
	exit(0)
end

require 'fileutils'

def run_ocr(start, stop, inpath_root, outpath_root, lang)
	puts "Run: #{start} -> #{stop}"
	(start..stop).each do |num|
		inpath = "#{inpath_root}/#{num}.png"
		outpath = "#{outpath_root}/#{num}"
		puts inpath
		data = `tesseract #{inpath} #{outpath} -l #{lang}`
	end
end

inpath_root = ARGV.length > 3 ? ARGV[3] : "./fix_verser"
outpath_root = ARGV.length > 4 ? ARGV[4] : "./fix_texter"

start = ARGV.length > 0 ? ARGV[0].to_i(10) : 1
stop = ARGV.length > 1 ? ARGV[1].to_i(10) : start
lang = ARGV.length > 2 ? ARGV[2] : "swe"

FileUtils.mkdir_p(inpath_root)
FileUtils.mkdir_p(outpath_root)

run_ocr(start, stop, inpath_root, outpath_root, lang)
