class Player

	ACCELERATION   = 1.2
	FRICTION       = 0.9
	ROTATION_SPEED = 5

	attr_reader :x, :y, :angle, :radius, :killed
	
	def initialize(window)
		@x = 200
		@y = 200
		@angle = 0
		@image = Gosu::Image.new("images/ship.png")
		@window = window
		@velocity_x = 0
		@velocity_y = 0
		@radius = 20
		@killed = false
	end

	def kill!
		@killed = true
	end

	alias_method :killed?, :killed

	def draw
		@image.draw_rot(@x, @y, 1, @angle) unless killed
	end

	def update
		return if killed
		turn_left  if @window.button_down?(Gosu::KbLeft)
		turn_right if @window.button_down?(Gosu::KbRight)
		accelerate if @window.button_down?(Gosu::KbUp)

		move
	end	

	def turn_right
		@angle += ROTATION_SPEED
		@angle %= 360
	end

	def turn_left
		@angle -= ROTATION_SPEED
		@angle += 360 # Make positive
		@angle %= 360 # Make between 0 and 360
	end

	def accelerate
		@velocity_x += Gosu.offset_x(@angle, ACCELERATION)
		@velocity_y += Gosu.offset_y(@angle, ACCELERATION)
	end

	def speed
		Math.sqrt(@velocity_x.abs ** 2 + @velocity_y ** 2)
	end

	def move
		@x += @velocity_x
		@y += @velocity_y
		@velocity_x *= FRICTION
		@velocity_y *= FRICTION

		if @x > @window.width - @radius
			@velocity_x = 0
			@x = @window.width - @radius
		end

		if @x < @radius
			@velocity_x = 0
			@x = @radius
		end

		if @y > @window.height - @radius
			@velocity_y = 0
			@y = @window.height - @radius
		end

		if @y < @radius
			@velocity_y = 0
			@y = @radius
		end
	end

end
