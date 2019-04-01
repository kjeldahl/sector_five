class ZigZagEnemy

	SPEED = 4

	attr_reader :x, :y, :radius, :speed, :off_screen

	def initialize(window)
		@radius = 20
		@x = rand(window.width / 2 - 2 * @radius) + @radius + window.width / 4
		@y = @radius
		@image = Gosu::Image.new("images/enemy.png")
		@window = window
		@angle_index = 0
		@angles = [135, 225]
		@angle = @angles[@angle_index]
		@speed = SPEED
		@ticks_to_change_direction = window.height / 4 / @speed
		@total_ticks = 0
	end

	def angle
		@angle
	end

	def draw
		@image.draw_rot(@x, @y, 1, angle)
	end

	def update
		@total_ticks += 1
		if @total_ticks % @ticks_to_change_direction == 0
			@angle_index += 1
			@angle_index %= @angles.size
		end
		@angle = @angles[@angle_index]
  		move
	end

	def move
		@velocity_x = Gosu.offset_x(@angle, @speed)
		@velocity_y = Gosu.offset_y(@angle, @speed)

		@x += @velocity_x
		@y += @velocity_y

		@off_screen = @y > @window.height + @radius
	end
end

