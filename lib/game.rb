class Game < Chingu::Window
  attr_accessor :tile_width, :tile_height,
    :width, :height,
    :grid

  def initialize
    self.input = { :escape => :exit }

    @width = 800
    @height = 800
    super(@width,@height,false)

    @tile_width, @tile_height = 100, 100
    create_current_tile
    create_grid
    draw_grid_background
    puts @current_tile
    $grid.place_tile!(@current_tile)
    create_current_tile
    puts $grid.tiles
  end

  def grid
    $grid
  end

  def create_grid
    $grid = Grid.new(width, height, tile_width, tile_height)
  end

  def draw_grid_background
    (0..grid.max_tile_x).each do |x_index|
      offset_x = x_index * tile_width + (tile_width / 2)
      (0..grid.max_tile_y).each do |y_index|
        offset_y = y_index * tile_height + (tile_height / 2)
        BackgroundTile.create({:image => Image["Outline.png"], :x =>offset_x, :y => offset_y, :zorder => ZORDER[:bg]})
      end
    end
  end

  def create_current_tile
    @current_tile = CurrentGameTile.create({:x => (tile_width / 2), :y => (tile_height / 2)})
    @current_tile.input = {
      :left => :move_left, 
      :right => :move_right, 
      :up => :move_up, 
      :down => :move_down,
      :space => :rotate_clockwise,
      # :enter => :place_tile,
      :return => :place_tile,
    }
    @current_tile.width = @tile_width
    @current_tile.height = @tile_height
  end

  def update
    super
    self.caption = "--=[ caRcassonne ]=-- an open source Ruby implementation of Carcassonne       (FPS: #{self.fps})" # milliseconds_since_last_tick: #{self.milliseconds_since_last_tick}"
  end
end