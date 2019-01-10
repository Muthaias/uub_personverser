start = ARGV[0].to_i
stop = ARGV[1].to_i
puts "Run: #{start} -> #{stop}"
(start..stop).each do |num|
    inpath = "./fix_verser/#{num}.png"
    outpath = "./fix_texter/#{num}"
    puts inpath
    data = `tesseract #{inpath} #{outpath} -l swe`
end