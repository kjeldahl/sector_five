class TrippleShotGun

	def initialize(window, player)
		@window = window
		@player = player
	end

	def shoot
		[0, 45, -45].map do |angle|
			Bullet.new(@window, @player.x, @player.y, @player.angle + angle + rand(6) - 3, @player.speed)
		end
	end
end