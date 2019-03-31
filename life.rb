class Life

  def initialize(window, text, x, y, player)
    @window = window
    @x = x
    @y = y
    @text = text
    @player = player
    @font = Gosu::Font.new(24)
  end

  def update
  end

  def draw
    @font.draw_text("Lives: #{@player.lives}", @x, @y, 1)
  end

end

