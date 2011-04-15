class CurrentGameTile < GameTile
  def setup
    tile.grid_x = 0
    tile.grid_y = 0
  end

  def move_left
    debug_coords
    @x -= width unless @x <= width
    tile.grid_x -= 1 unless tile.grid_x <= 0
  end

  def move_right
    @x += width unless (@x + width) >= $window.width
    tile.grid_x += 1 unless (tile.grid_x + 1) == $grid.max_tile_x
    debug_coords
  end

  def move_up
    @y -= height unless @y <= height
    tile.grid_y -= 1 unless tile.grid_y <= 0
    debug_coords
  end

  def move_down
    @y += height unless (@y + height) >= $window.height
    tile.grid_y += 1 unless (tile.grid_y + 1) == $grid.max_tile_y
    debug_coords
  end

  def rotate_clockwise
    @angle += 90
    tile.rotate_clockwise
    debug_subgrid
  end

  def place_tile
    puts "placing tile"
    $grid.place_tile(tile)
    debug_grid
  end

private
  def debug_coords
    puts "Grid: [#{tile.grid_x}:#{x},#{tile.grid_y}:#{y}]"
  end

  def debug_grid
    puts $grid.tiles.to_yaml
  end

  def debug_subgrid
    puts tile.sub_grid
  end
end