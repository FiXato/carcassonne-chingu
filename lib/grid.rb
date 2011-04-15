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
    @tiles[tile.grid_y][tile.grid_x] = tile
  end
end