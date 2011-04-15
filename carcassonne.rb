require 'chingu'
include Gosu
Gosu::Image.autoload_dirs << File.join(ROOT, File.join("resources","tiles","Carcassonne Classic[16 colours]"))
ZORDER = {:bg => 0, :current_tile => 10}

class Game < Chingu::Window
  attr_accessor :tile_width, :tile_height,
    :width, :height

  def initialize
    self.input = { :escape => :exit }

    @width = 800
    @height = 800
    super(@width,@height,false)

    @tile_width, @tile_height = 100, 100
    create_current_tile
    create_background
  end

  def create_background
    (0..(width/tile_width)).each do |x_index|
      offset_x = x_index * tile_width + (tile_width / 2)
      (0..(height/tile_height)).each do |y_index|
        offset_y = y_index * tile_height + (tile_height / 2)
        BackgroundTile.create({:image => Image["Outline.png"], :x =>offset_x, :y => offset_y, :zorder => ZORDER[:bg]})
      end
    end
  end

  def create_current_tile
    @current_tile = CurrentTile.create({:x => (tile_width / 2), :y => (tile_height / 2)})
    @current_tile.input = {
      :left => :move_left, 
      :right => :move_right, 
      :up => :move_up, 
      :down => :move_down,
    }
    @current_tile.width = @tile_width
    @current_tile.height = @tile_height
  end

  def update
    super
    self.caption = "--=[ caRcassonne ]=-- an open source Ruby implementation of Carcassonne       (FPS: #{self.fps})" # milliseconds_since_last_tick: #{self.milliseconds_since_last_tick}"
  end
end

class Tile < Chingu::GameObject
  trait :bounding_box, :scale => 1.0, :debug => true
  attr_accessor :width, :height

  def initialize(options)
    super(options.merge(:image => Image["City11we.png"], :zorder => ZORDER[:current_tile]))
  end
end

class CurrentTile < Tile
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

class BackgroundTile < Chingu::GameObject
  # trait :bounding_box, :scale => 1.0, :debug => true
end

Game.new.show   # Start the Game update/draw loop!
