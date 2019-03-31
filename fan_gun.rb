class FanGun

	def initialize(window, player)
		@window = window
		@player = player
	end

	def shoot
		[0, 10, -10, 20, -20, 30, -30, 45, -45].map do |angle|
			Bullet.new(@window, @player.x, @player.y, @player.angle + angle + rand(6) - 3, @player.speed + rand(10))
		end
	end
end