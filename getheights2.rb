allPoints = RoutePoint.all;
File.open("output.txt",'w') do |ofile|
	allPoints.each do |point|
		ofile.print "#{point.id};#{point.lat};#{point.long};\n";
	end
end

