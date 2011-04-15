class SubTile
  attr_accessor :number
  def initialize
    @number = increase_counter
  end
  def increase_counter
    counter_name = "@@#{self.class.name}_counter".downcase
    self.class.class_variable_set(counter_name, 0) unless self.class.class_variable_defined?(counter_name)
    self.class.class_variable_set(counter_name, self.class.class_variable_get(counter_name) + 1)
  end
end

class Meadow < SubTile
end
class Road < SubTile
end
class Crossing < Road
end
class City < SubTile
end
class Monastery < SubTile
end

class Tile
  attr_accessor :image_filename, :sub_grid, :rotation, :grid_x, :grid_y
  def initialize
    # @image_filename = "City11we.png"
    # @sub_grid = [
    #   [[:city],[:meadow],[:city]],
    #   [[:city],[:meadow],[:city]],
    #   [[:city],[:meadow],[:city]]
    # ]
    @image_filename = "Road-swe - 1.png"
    @sub_grid = [
      [[m = Meadow.new],[m],[m]],
      [[Road.new],[Crossing.new],[Road.new]],
      [[Meadow.new],[Road.new],[Meadow.new]]
    ]
    @rotation = 0
  end

  def rotate_clockwise
    self.rotation += 90
    self.sub_grid = sub_grid.reverse.transpose
  end
end

class GameTile < Chingu::GameObject
  trait :bounding_box, :scale => 1.0, :debug => true
  attr_accessor :width, :height, :tile

  def initialize(options)
    @tile = Tile.new()
    super(options.merge(:image => Image[tile.image_filename], :zorder => ZORDER[:current_tile]))
  end
end
