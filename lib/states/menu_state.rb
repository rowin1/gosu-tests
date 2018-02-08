require 'singleton'

class MenuState < GameState
  include Singleton
  attr_accessor :play_state

  def initialize
    @message_text = Gosu::Image.from_text($window,
                                     "Yahtzee",
                                     Gosu.default_font_name,
                                     60)
  end

  def enter
    music.play(true)
    music.volume = 1
  end

  def leave
    music.volume = 0
    music.stop
  end

  def music
    @@music ||= Gosu::Song.new($window, Utils.media_path('menu_music.wav'))
  end

  def update
    text = "Q: Quit\nN: New Game"
    text << "\nC: Continue" if @play_state
    @info_text = Gosu::Image.from_text($window,
      text, Gosu.default_font_name, 30)
  end

  def draw
    @message_text.draw($window.width / 2 - @message_text.width / 2,
                       $window.height / 2 - @message_text.height / 2,
                       10)
    @info_text.draw($window.width / 2 - @info_text.width / 2,
                    $window.height / 2 - @info_text.height / 2 + 100,
                    10)
  end

  def button_down(id)
    $window.close if id == Gosu::KbQ
    if id == Gosu::KbC && @play_state
      GameState.switch(@play_state)
    end
    if id == Gosu::KbN
      @play_state = PlayState.new
      GameState.switch(@play_state)
    end
  end
end
