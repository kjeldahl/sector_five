module Scenes
	class Start

		def initialize(window, game_state)
      @window = window
      @game_state = game_state
			@backgound_image = Gosu::Image.new("images/start_screen.png")
			@done = false
		end

		def draw
			@backgound_image.draw(0, 0, 1)
		end

		def update
		end

		def button_down(id)
			@done = true
		end

		def done?
			@done
		end
	end
end	