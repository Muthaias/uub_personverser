if (ARGV.include?("--h") || ARGV.include?("-help"))
	puts "Execute octave script to preprocess images:"
	puts " Usage: ruby preprocess.rb [start|1] [stop|start] [inpath_root|./verser] [outpath_root|./fix_verser]"
	exit(0)
end

require 'fileutils'

def run_preprocessing(start, stop, inpath_root, outpath_root)
	dirname = File.dirname(__FILE__);
	system("octave-cli -qf #{dirname}/octave/exec_loop_images.m #{start} #{stop} #{inpath_root} #{outpath_root}")
end

inpath_root = ARGV.length > 2 ? ARGV[2] : "./verser"
outpath_root = ARGV.length > 3 ? ARGV[3] : "./fix_verser"

start = ARGV.length > 0 ? ARGV[0].to_i(10) : 1
stop = ARGV.length > 1 ? ARGV[1].to_i(10) : start

FileUtils.mkdir_p(outpath_root)

run_preprocessing(start, stop, inpath_root, outpath_root)
