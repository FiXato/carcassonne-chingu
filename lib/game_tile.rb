class Tile
  attr_accessor :image_filename, :sub_grid, :rotation
  def initialize
    # @image_filename = "City11we.png"
    # @sub_grid = [
    #   [[:city],[:meadow],[:city]],
    #   [[:city],[:meadow],[:city]],
    #   [[:city],[:meadow],[:city]]
    # ]
    @image_filename = "Road-swe - 1.png"
    @sub_grid = [
      [[:meadow],[:meadow],[:meadow]],
      [[:road],[:crossing],[:road]],
      [[:meadow],[:road],[:meadow]]
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
