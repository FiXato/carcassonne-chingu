class Grid
  attr_accessor :max_tile_x, :max_tile_y, :max_subgrid_x, :max_subgrid_y,
  :tiles#, :tile_images, :starting_tile, :offset
  def initialize(width, height, tile_width, tile_height)
    @max_tile_x = width/tile_width
    @max_tile_y = height/tile_height
    @max_subgrid_x = (width/tile_width)*3
    @max_subgrid_y = (height/tile_height)*3
    @tiles = Array.new(max_tile_y) {|i| Array.new(max_tile_x)}
  end

  def tile(x,y)
    @tiles[y][x]
  end

  def place_tile(tile)
    if tile.grid_x > max_tile_x || tile.grid_y > max_tile_y
      puts "Tile has to be placed inside the Grid"
      return false
    end

    if tile(tile.grid_x,tile.grid_y)
      puts "Already a tile present on this position"
      return false
    end
    
    unless tile.compatible?(north_tile = tile(tile.grid_x,tile.grid_y - 1),:north)
      puts "North tile not compatible"
      return false
    end

    unless tile.compatible?(south_tile = tile(tile.grid_x,tile.grid_y + 1),:south)
      puts "South tile not compatible"
      return false
    end

    unless tile.compatible?(east_tile = tile(tile.grid_x + 1,tile.grid_y),:east)
      puts "East tile not compatible"
      return false
    end

    unless tile.compatible?(west_tile = tile(tile.grid_x + 1,tile.grid_y),:west)
      puts "West tile not compatible"
      return false
    end
    
    if [north_tile,south_tile,east_tile,west_tile].compact == [] #has to be attached to at least 1 tile
      puts "No tile to connect to."
      return false
    end

    puts "Tile placed!"

    place_tile!(tile)
  end

  def place_tile!(tile)
    puts tile
    puts tile.grid_y
    puts tile.grid_x
    @tiles[tile.grid_y][tile.grid_x] = tile
  end
end