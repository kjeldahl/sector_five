module Scenes
	class Start

		def initialize(window, game_state)
      @window = window
      @game_state = game_state
			@backgound_image = Gosu::Image.new("images/start_screen.png")
			@start_music = Gosu::Song.new('sounds/Lost Frontier.ogg')
			@start_music.play(true)
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

		def end!
			@start_music.stop
		end
	end
end	