class CurrentGameTile
  attr_accessor :tile

  def initialize(tile)
    @tile = tile
    tile.grid_x = 0
    tile.grid_y = 0
  end

  def move_left
    debug_coords
    tile.x -= width unless tile.x <= width
    tile.grid_x -= 1 unless grid_x <= 0
  end

  def move_right
    @x += width unless (@x + width) >= $window.width
    @grid_x += 1 unless (grid_x + 1) == $grid.max_tile_x
    debug_coords
  end

  def move_up
    @y -= height unless @y <= height
    @grid_y -= 1 unless grid_y <= 0
    debug_coords
  end

  def move_down
    @y += height unless (@y + height) >= $window.height
    @grid_y += 1 unless (grid_y + 1) == $grid.max_tile_y
    debug_coords
  end

  def rotate_clockwise
    super
    debug_subgrid
  end

  def place_tile
    puts "placing tile"
    if $grid.place_tile(self)
      debug_grid
    end
  end

private
  def debug_coords
    puts "Grid: [#{grid_x}:#{x},#{grid_y}:#{y}]"
  end

  def debug_grid
    puts $grid.tiles
  end

  def debug_subgrid
    puts sub_grid
  end

  def width
    tile.width
  end
  
  def height
    tile.height
  end
end