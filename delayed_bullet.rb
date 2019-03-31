require_relative 'bullet'

class DelayedBullet < Bullet

	def initialize(window, player, delay)
		super(window, player.x, player.y, player.angle, player.speed)
		@player = player
		@delay = delay
	end

	def update
		if @delay == 0
			@x = @player.x
			@y = @player.y
			@angle = @player.angle
			@speed = @player.speed + bullet_speed
		end
		move if @delay < 0
		@delay -= 1
	end

	def draw
		super if @delay < 0
	end

end

