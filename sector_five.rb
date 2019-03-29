#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require 'ostruct'
require_relative "bullet"
require_relative "credit"
require_relative "enemy"
require_relative "enemy_bullet"
require_relative "explosion"
require_relative "player"
require_relative "scenes/end"
require_relative "scenes/game"
require_relative "scenes/start"

class SectorFive < Gosu::Window
	
  WIDTH  = 800
	HEIGHT = 600
  
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @game_state = OpenStruct.new
    @scene = Scenes::Start.new(self, @game_state)
  end

  def draw
  	@scene.draw
  end

  def update
    @scene.update
    if @scene.done?
        if @scene.is_a? Scenes::Start
          @scene = Scenes::Game.new(self, @game_state)
        elsif @scene.is_a? Scenes::Game
          @scene = Scenes::End.new(self, @game_state)
        elsif @scene.is_a? Scenes::End
          if @game_state.restart
            @scene = Scenes::Game.new(self, @game_state)
          else
            exit(0)
          end
        end
    end
  end

  def button_down(id)
    @scene.button_down(id)
  end

end

window = SectorFive.new 
window.show
