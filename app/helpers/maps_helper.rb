module MapsHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Maps for "
    if page_title.empty?
      page_title = "Unknown Park"
    end
    return "#{base_title} #{page_title}"
  end
  
  def randomColor
		color = "#%06x" % (rand * 0xffffff)
		return color
	end  
  
  def safeName(name)
		return name.gsub(/\W/, '') 
	end
  
  def iconName(name)
		return "icon_#{safeName(name)}";
  end  
  
  def highlightName(name)
		return "hi_icon_#{safeName(name)}";
  end  
  
  def layerName(name)
		return "layer_#{safeName(name)}";
  end 
  
  def iconSize(id)
		case id
		when 1 
			return "SmallIcon";
		when 2
			return "MedIcon";
		when 3
			return "LargeIcon";
		end
	end 
end
