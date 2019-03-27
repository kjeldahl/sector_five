#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require_relative "player"
require_relative "enemy"

class SectorFive < Gosu::Window
	WIDTH  = 800
	HEIGHT = 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = 10.times.map { Enemy.new(self) }
  end

  def draw
  	@player.draw
  	@enemies.each &:draw
  end

  def update
  	@player.update
  	@enemies.each &:update
  end
end

window = SectorFive.new
window.show
