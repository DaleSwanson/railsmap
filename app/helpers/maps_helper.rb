module MapsHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Maps for "
    if page_title.empty?
      page_title = "Unknown Park"
    end
    return "#{base_title} #{page_title}"
  end
  
end
