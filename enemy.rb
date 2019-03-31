class Enemy

	SPEED = 4

	attr_reader :x, :y, :radius, :speed, :off_screen

	def initialize(window)
		@radius = 20
		@x = rand(window.width - 2 * @radius) + @radius
		@y = 0
		@image = Gosu::Image.new("images/enemy.png")
		@window = window
		@direction = 1
		@speed = SPEED + rand(4) - 2
	end

	def angle
		@direction < 0 ? 0 : 180
	end

	def draw
		@image.draw_rot(@x, @y, 1, (angle - 180).abs)
	end

	def update
  		move
	end

	def move
		@y += @speed * @direction

		@off_screen = @y > @window.height + @radius


		# Turn around
		# if @y > @window.height - @radius
		# 	@y = @window.height - @radius
		# 	@direction *= -1
		# end
		# if @y < @radius
		# 	@y = @radius
		# 	@direction *= -1
		# end
	end
end

