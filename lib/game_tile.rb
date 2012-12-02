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

  def compatible?(sub_tile)
    self.class.name == sub_tile.class.name
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

class Tile < Chingu::GameObject
  trait :bounding_box, :scale => 1.0, :debug => true
  attr_accessor :width, :height, :image_filename, :sub_grid, :angle, :grid_x, :grid_y

  def initialize(options)
    # @image_filename = "City11we.png"
    # @sub_grid = [
    #   [[:city],[:meadow],[:city]],
    #   [[:city],[:meadow],[:city]],
    #   [[:city],[:meadow],[:city]]
    # ]
    @image_filename = "Road-swe - 1.png"
    @sub_grid = [
      [m = Meadow.new,m,m],
      [Road.new,Crossing.new,Road.new],
      [Meadow.new,Road.new,Meadow.new]
    ]
    @rotation = 0
    super(options.merge(:image => Image[image_filename], :zorder => ZORDER[:current_tile]))
  end

  def compatible?(tile, direction)
    return true if tile.nil?
    case direction
    when :north
      north.compatible?(tile.south)
    when :south
      south.compatible?(tile.north)
    when :east
      east.compatible?(tile.west)
    when :west
      west.compatible?(tile.east)
    end
  end

  def rotate_clockwise
    @angle += 90
    self.sub_grid = sub_grid.reverse.transpose
  end

  def north
    sub_grid[0][1] rescue nil
  end

  def south
    sub_grid[2][1] rescue nil
  end

  def east
    sub_grid[1][2] rescue nil
  end

  def west
    sub_grid[1][0] rescue nil
  end
end
