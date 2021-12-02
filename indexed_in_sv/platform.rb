require 'date'
require "pp"

dates={}


IO.foreach(ARGV.first) do |item| 
	item.chomp!
	if !item.match(/[a-zA-Z0-9]+\.\d{5}\.\d{4}/)
		STDERR.puts "Not liking: #{item}"
		next
	end
	peices = /([a-zA-Z0-9]+)\.(\d{5}\.\d{4})/.match(item)
	#puts peices[1]
	#puts peices[2]
	begin	
		bin =  DateTime.strptime(peices[2], "%y%j.%H%M").strftime("%Y")
	rescue ArgumentError
		STDERR.puts "Invalid date #{item}"
		next
	end

	platform = peices[1]	
	
	
	dates[platform] = {} unless dates[platform]
	dates[platform][bin] = 0 unless dates[platform][bin]
	dates[platform][bin] += 1
end

dates.keys.sort.each do |dt| 
	line = dt + "\t" 
	dates[dt].keys.sort.each do |platform| 
		line += "#{platform}(#{dates[dt][platform]})\t"
	end
	puts line
end

