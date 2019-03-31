class DelayedBullet < Bullet

	def initialize(window, x, y, angle, speed, delay)
		super(window, x, y, angle, speed)
		@delay = delay
	end

	def update
		move if @delay < 0
		@delay -= 1
	end

	def draw
		super if @delay < 0
	end

end

