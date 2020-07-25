class CachableFile
	attr_accessor :id, :url, :path
	def initialize(id, url, path)
		@id = id
		@url = url
		@path = path
	end
end

class FileDownloader
	def initialize(files)
		@fileMap = files.reduce(Hash.new) do |map, file|
			map[file.id] = file
			map
		end
	end

	def list_files()
		@fileMap.map{|id, file| id}
	end

	def file(id)
		file = @fileMap[id]
	end

	def self.from_array_ids(ids, gen_url, gen_path)
		files = ids.map{|id| CachableFile.new(id, gen_url.call(id), gen_path.call(id))}
		FileDownloader.new(files)
	end

	def self.download_entry(file)
		puts file.url
		data = `curl "#{file.url}" --output #{file.path}`
	end
end