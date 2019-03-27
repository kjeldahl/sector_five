class Bullet

	SPEED = 5

	attr_reader :x, :y, :angle, :radius

	def initialize(window, x, y, angle)
		@window = window
		@x = x
		@y = y
		@angle = angle
		@image = Gosu::Image.new("images/bullet.png")
		@radius = 3
	end

	def draw
		@image.draw(@x - @radius, @y - @radius, 1)
	end

	def update
		move
	end

	def move
		@x += Gosu.offset_x(@angle, SPEED)
		@y += Gosu.offset_y(@angle, SPEED)
	end
end
