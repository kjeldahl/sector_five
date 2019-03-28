class Explosion

	SPEED = 2

	attr_reader :finished

	class << self
		def calculate_angle(enemy, bullet)
			bullet.angle
		end
    end

	def initialize(window, x, y, angle)
		@window = window
		@x = x
		@y = y
		@angle = angle
		@radius = 30
	    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
	    @image_index = 0
	    @finished = false 
	end

	def update
		move
	end

	def move
		@x += Gosu.offset_x(@angle, SPEED)
		@y += Gosu.offset_y(@angle, SPEED)
	end

	def draw
		unless finished
			@images[@image_index].draw(@x - @radius, @y - @radius, 1)
			@image_index += 1
			@finished = @image_index == @images.size
		end
	end

end
