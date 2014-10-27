require 'watir'

b = Watir::Browser.new :firefox

('A'..'Z').each do |letter|
	b.goto "http://en.wikipedia.org/wiki/UK_railway_stations_%E2%80%93_" + letter
	
	if /([^XZ])/.match letter # there are no stations that start with the letter X or Z
		stations_tbl = b.table(:class, 'wikitable')
		stations = stations_tbl.trs

		stations.each_with_index do |station, index|
			if index > 0
				File.open('data/uk_stations_list.txt', 'a') do |file|
					file.puts "(" + station.td(:index => 0).text + ")"
				end
			end
		end
	end
end

b.close