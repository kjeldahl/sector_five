require_relative 'delayed_bullet'
class ThreeShotGun

	def initialize(window, player)
		@window = window
		@player = player
	end

	def shoot
		[0, 5, 10].map do |delay|
			DelayedBullet.new(@window, @player.x, @player.y, @player.angle, @player.speed, delay)
		end
	end
end