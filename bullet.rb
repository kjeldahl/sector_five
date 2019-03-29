class Bullet

	attr_reader :x, :y, :angle, :radius, :off_screen

	def initialize(window, x, y, angle, speed)
		@window = window
		@x = x
		@y = y
		@angle = angle % 360
		@speed = speed + bullet_speed
		@image = Gosu::Image.new("images/bullet.png")
		@radius = 3
	end

	def bullet_speed
		10
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end

	def update
		move
	end

	def move
		@x += Gosu.offset_x(@angle, @speed)
		@y += Gosu.offset_y(@angle, @speed)

		on_screen = (-@radius..(@window.width+@radius)).cover?(@x) && (-@radius..(@window.height+@radius)).cover?(@y)
		@off_screen = !on_screen
	end
end
