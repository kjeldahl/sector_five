class SingleShotGun

	def initialize(window, player)
		@window = window
		@player = player
	end

	def shoot
		 [Bullet.new(@window, @player.x, @player.y, @player.angle, @player.speed)]
	end
end