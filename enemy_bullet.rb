require_relative 'bullet'

class EnemyBullet < Bullet

	def initialize(window, x, y, angle, speed)
		super(window, x, y, angle, speed)
		@image = Gosu::Image.new("images/enemy_bullet.png")
	end

end