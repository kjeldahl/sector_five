class LifeAndScore

  def initialize(window, player, game_state)
    @window = window
    @player = player
    @game_state = game_state
    @font = Gosu::Font.new(24)
  end

  def update
  end

  def draw
    @font.draw_text("Lives: #{@player.lives}", 5, 24, 1)
    @font.draw_text("Score: #{@game_state.enemies_destroyed}/#{@game_state.enemies_appeared}", @window.width / 2 - 150, 24, 1)
  end

end

