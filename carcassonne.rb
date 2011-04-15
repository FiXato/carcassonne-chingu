#!/usr/bin/env ruby
require 'chingu'
include Gosu
unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
  $LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__),'lib')))
end
Gosu::Image.autoload_dirs << File.join(ROOT, File.join("resources","tiles","Carcassonne Classic[16 colours]"))

ZORDER = {:bg => 0, :current_tile => 10}
require 'game'
require 'game_tile'
require 'current_game_tile'
require 'background_tile'
require 'grid'
Game.new.show   # Start the Game update/draw loop!
