require 'gosu'
require_relative "../bullet"
require_relative "../enemy"
require_relative "../enemy2"
require_relative "../enemy_bullet"
require_relative "../explosion"
require_relative "../life_and_score"
require_relative "../player"
require_relative "../zig_zag_enemy"

module Scenes
	class Game
		
	  ENEMY_FREQUENCY = 0.005
	  ENEMY_SHOOT_FREQUENCY = 0.005
	  MAX_ENEMIES = 10
	  
	  def initialize(window, game_state)
      @window = window
      @game_state = game_state
	    @player = Player.new(window)
	    @enemies = []
	    @bullets = []
	    @enemy_bullets = []
	    @explosions = []
	    @life_counter = LifeAndScore.new(@window, @player, @game_state)

      @game_state.fate = nil
	    @game_state.enemies_appeared = 0
	    @game_state.enemies_destroyed = 0

	    @music = Gosu::Song.new('sounds/Cephalopod.ogg')
	    @music.play(true)

	    @explosion_sound = Gosu::Sample.new('sounds/explosion.ogg')

	    @done = false
	  end

	  def done?
	  	!@game_state.fate.nil?
	  end

	  def end!
	  	@music.stop
	  end

	  def draw
	  	@player.draw
	  	@enemies.each &:draw
	    @bullets.each &:draw
	    @enemy_bullets.each &:draw
	    @explosions.each &:draw
	    @life_counter.draw
	  end

	  def update
	  	@player.update
	  	@enemies.each &:update
	    @bullets.each &:update
	    @enemy_bullets.each &:update
	    @explosions.each &:update
	    @life_counter.update

	    # Spawn Enemy
	    if rand < ENEMY_FREQUENCY && !@player.killed
	      @enemies << ZigZagEnemy.new(@window)
	      @game_state.enemies_appeared += 1
        @game_state.fate = :count_reached if @game_state.enemies_appeared > MAX_ENEMIES
	    end

	    # Enemy Shoot
	    @enemies.each do |enemy|
	      if rand < ENEMY_SHOOT_FREQUENCY
	        @enemy_bullets << EnemyBullet.new(@window, enemy.x, enemy.y, Gosu.angle(enemy.x, enemy.y, @player.x, @player.y) + rand(20)-10, enemy.speed)
	      end
	    end unless @player.killed?

	    # Collision detection enemies and bullet
	    enemies_and_bullets_to_remove = []
	    @enemies.each do |enemy|
	      @bullets.each do |bullet|
	        
	        if Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) < enemy.radius + bullet.radius
	          enemies_and_bullets_to_remove << bullet
	          enemies_and_bullets_to_remove << enemy
	          @explosions << Explosion.new(@window, enemy.x, enemy.y, Explosion.calculate_angle(enemy,bullet))
	          @explosion_sound.play
	          @game_state.enemies_destroyed += 1
	        end

	      end
	    end
	 
	    # Collision detection player and enemy bullets
	    @enemy_bullets.each do |bullet|
	      
	      if Gosu.distance(@player.x, @player.y, bullet.x, bullet.y) < @player.radius + bullet.radius
	        enemies_and_bullets_to_remove << bullet
	        enemies_and_bullets_to_remove << @player
	        @player.kill!
	        @explosions << Explosion.new(@window, @player.x, @player.y, Explosion.calculate_angle(@player,bullet))
          @game_state.fate = :hit_by_enemy if @player.killed?
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
	    @enemies.reject! &:off_screen
	    @enemy_bullets.reject! &:off_screen
	  end

	  def button_down(id)
	    # Shoot bullets
	    if id == Gosu::KbSpace
	    	@player.shoot.each do |bullet|
	    		@bullets << bullet
	    	end
	      # @bullets << Bullet.new(@window, @player.x, @player.y, @player.angle, @player.speed)
	    end
	    @player.button_down(id) if @player.respond_to? :button_down
	  end

	end
end