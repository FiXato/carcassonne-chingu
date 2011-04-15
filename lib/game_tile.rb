class GameTile < Chingu::GameObject
  trait :bounding_box, :scale => 1.0, :debug => true
  attr_accessor :width, :height

  def initialize(options)
    super(options.merge(:image => Image["City11we.png"], :zorder => ZORDER[:current_tile]))
  end
end
