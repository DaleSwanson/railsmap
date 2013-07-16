allPois = Poi.where(elevation: 1000);
File.open("output.txt",'w') do |ofile|
	allPois.each do |poi|
		poi
		ofile.print "#{poi.id};#{poi.lat};#{poi.long}\n";
	end
end
