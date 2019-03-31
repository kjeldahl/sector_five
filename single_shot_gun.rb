class SingleShotGun

	def initialize(window, player)
		@window = window
		@player = player
		@shoot_sound = Gosu::Sample.new('sounds/shoot.ogg')
	end

	def shoot
		@shoot_sound.play(0.3, 1 + rand(0.2) - 0.1)
		[Bullet.new(@window, @player.x, @player.y, @player.angle, @player.speed)]
	end
end