class PlayState < GameState
  # attr_accessor :object_pool
  def initialize
    @yahtzee = Yahtzee.new
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
    text = "rolls: #{@yahtzee.rolls}"
    @round_text = Gosu::Image.from_text($window,
      text, Gosu.default_font_name, 30)
  end

  def draw
    @round_text.draw($window.width / 2 - @round_text.width / 2,
                    $window.height / 2 - @round_text.height / 2 + 100,
                    10)
    @yahtzee.draw
  end

  def button_down(id)
    $window.close if id == Gosu::KbQ
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
    if id == Gosu::KbSpace
      @yahtzee.reroll
    end
  end
end