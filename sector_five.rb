#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require_relative "bullet"
require_relative "enemy"
require_relative "enemy_bullet"
require_relative "explosion"
require_relative "player"

class SectorFive < Gosu::Window
	
  WIDTH  = 800
	HEIGHT = 600
  ENEMY_FREQUENCY = 0.005
  ENEMY_SHOOT_FREQUENCY = 0.005
  
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @enemy_bullets = []
    @explosions = []
  end

  def draw
  	@player.draw
  	@enemies.each &:draw
    @bullets.each &:draw
    @enemy_bullets.each &:draw
    @explosions.each &:draw
  end

  def update
  	@player.update
  	@enemies.each &:update
    @bullets.each &:update
    @enemy_bullets.each &:update
    @explosions.each &:update

    # Spawn Enemy
    if rand < ENEMY_FREQUENCY && !@player.killed
      @enemies << Enemy.new(self)
    end

    # Enemy Shoot
    @enemies.each do |enemy|
      if rand < ENEMY_SHOOT_FREQUENCY
        @enemy_bullets << EnemyBullet.new(self, enemy.x, enemy.y, Gosu.angle(enemy.x, enemy.y, @player.x, @player.y), enemy.speed)
      end
    end

    # Collision detection enemies and bullet
    enemies_and_bullets_to_remove = []
    @enemies.each do |enemy|
      @bullets.each do |bullet|
        
        if Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) < enemy.radius + bullet.radius
          enemies_and_bullets_to_remove << bullet
          enemies_and_bullets_to_remove << enemy	
          @explosions << Explosion.new(self, enemy.x, enemy.y, Explosion.calculate_angle(enemy,bullet))
        end

      end
    end
 
    # Collision detection player and enemy bullets
    @enemy_bullets.each do |bullet|
      
      if Gosu.distance(@player.x, @player.y, bullet.x, bullet.y) < @player.radius + bullet.radius
        enemies_and_bullets_to_remove << bullet
        enemies_and_bullets_to_remove << @player
        @player.kill!
        @explosions << Explosion.new(self, @player.x, @player.y, Explosion.calculate_angle(@player,bullet))
      end

    end

    # Clean up
    enemies_and_bullets_to_remove.each do |to_delete|
    	@enemies.delete to_delete
    	@bullets.delete to_delete
      @enemy_bullets.delete to_delete
    end

    @explosions.reject! &:finished
    @bullets.reject! &:off_screen
    @enemy_bullets.reject! &:off_screen
  end

  def button_down(id)
    # Shoot bullets
    if id == Gosu::KbSpace
      @bullets << Bullet.new(self, @player.x, @player.y, @player.angle, @player.speed)
    end
  end

end

window = SectorFive.new 
window.show
