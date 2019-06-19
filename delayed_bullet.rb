require_relative 'bullet'

class DelayedBullet < Bullet

	def initialize(window, player, delay)
		super(window, player.x, player.y, player.angle, player.speed)
		@player = player
		@delay = delay
		@shoot_sound = Gosu::Sample.new('sounds/shoot.ogg')
	end

	def update
		if @delay == 0
			@shoot_sound.play(0.3, 1 + rand(0.2) - 0.1)

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

