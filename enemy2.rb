class Enemy2

	SPEED = 4

	attr_reader :x, :y, :radius, :speed, :off_screen

	def initialize(window)
		@radius = 20
		@x = rand(window.width - 2 * @radius) + @radius
		@y = 0
		@image = Gosu::Image.new("images/enemy.png")
		@window = window
		target_x = rand(window.width - 2 * @radius) + @radius
		@angle = Gosu.angle(@x, @y, target_x, @window.height)
		@speed = SPEED + rand(4) - 2
		@velocity_x = Gosu.offset_x(@angle, @speed)
		@velocity_y = Gosu.offset_y(@angle, @speed)
	end

	def angle
		@angle
	end

	def draw
		@image.draw_rot(@x, @y, 1, (angle - 180))
	end

	def update
  		move
	end

	def move
		@x += @velocity_x
		@y += @velocity_y

		@off_screen = @y > @window.height + @radius
	end
end

