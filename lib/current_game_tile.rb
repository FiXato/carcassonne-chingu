class CurrentGameTile < GameTile
  def move_left
    @x -= width unless @x <= width
  end

  def move_right
    @x += width unless (@x + width) >= $window.width
  end

  def move_up
    @y -= height unless @y <= height
  end

  def move_down
    @y += height unless (@y + height) >= $window.height
  end
end