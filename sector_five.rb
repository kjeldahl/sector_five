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
require_relative "bullet"
require_relative "explosion"

class SectorFive < Gosu::Window
	WIDTH  = 800
	HEIGHT = 600
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
  end

  def draw
  	@player.draw
  	@enemies.each &:draw
    @bullets.each &:draw
    @explosions.each &:draw
  end

  def update
  	@player.update
  	@enemies.each &:update
    @bullets.each &:update
    @explosions.reject! &:finished
    @explosions.each &:update

    # Spawn Enemy
    if rand < ENEMY_FREQUENCY
      @enemies << Enemy.new(self)
    end

    # Collision detection
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        
        if Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) < enemy.radius + bullet.radius
          @bullets.delete bullet
          @enemies.delete enemy
          @explosions << Explosion.new(self, enemy.x, enemy.y, (enemy.angle + bullet.angle) / 2)
        end

      end
    end

  end

  def button_down(id)
    # Shoot bullets
    if id == Gosu::KbSpace
      @bullets << Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end

end

window = SectorFive.new 
window.show
