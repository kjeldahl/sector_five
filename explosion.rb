class Explosion

	attr_reader :finished

	def initialize(window, x, y)
		@window = window
		@x = x
		@y = y
		@radius = 30
	    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
	    @image_index = 0
	    @finished = false 
	end

	def update
		move
	end

	def move
	end

	def draw
		unless finished
			@images[@image_index].draw(@x - @radius, @y - @radius, 1)
			@image_index += 1
			@finished = @image_index == @images.size
		end
	end

end
