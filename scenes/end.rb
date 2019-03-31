require_relative '../credit'
require_relative 'game'

module Scenes
  class End

    WIDTH = 800

    def initialize(window, game_state)
      @window = window
      @game_state = game_state
      @game_state.reset = nil

      case @game_state.fate
      when :count_reached
        @message = "You made it! You destroyed #{@game_state.enemies_destroyed} ships"
        @message2= "and #{Scenes::Game::MAX_ENEMIES - @game_state.enemies_destroyed} reached the base."
      when :hit_by_enemy
        @message = " You were struck by an enemy ship."
        @message2= "Before your ship was destroyed, "
        @message2+= "you took out #{@game_state.enemies_destroyed} enemy ships."
      end

      @bottom_message = "Press P to play again, or Q to quit."
      @message_font = Gosu::Font.new(28)
      @credits = []

      y = 700

      File.open('credits.txt').each do |line|
        @credits.push(Credit.new(@window, line.chomp, 100, y))
        y += 30
      end
    end

    def draw
      @window.clip_to(50,140,700,360) do
        @credits.each &:draw
      end

      @window.draw_line(0, 140, Gosu::Color::RED, WIDTH, 140, Gosu::Color::RED)
      
      @message_font.draw_text(@message, 40, 40, 1, 1, 1, Gosu::Color::FUCHSIA)
      @message_font.draw_text(@message2, 40, 75, 1, 1, 1, Gosu::Color::FUCHSIA)

      @window.draw_line(0, 500, Gosu::Color::RED, WIDTH, 500, Gosu::Color::RED)

      @message_font.draw_text(@bottom_message, 180, 540, 1, 1, 1, Gosu::Color::AQUA)
    end

    def update
      @credits.each &:move
      @credits.each &:reset if @credits.last.y < 150  
    end

    def button_down(id)
      if id == Gosu::KbP
        @game_state.restart = true
        @done = true
      elsif id == Gosu::KbQ
        @game_state.restart = false
        @done = true
      end
    end

    def done?
      @done
    end

  end
end
