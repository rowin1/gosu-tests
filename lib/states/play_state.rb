class PlayState < GameState
  # attr_accessor :object_pool
  def initialize
    @yahtzee = Yahtzee.new
  end

  def enter
    music.play(true)
    music.volume = 0.6
  end

  def leave
    music.volume = 0
    music.stop
  end

  def music
    @@music ||= Gosu::Song.new($window, Utils.media_path('menu_music.wav'))
  end

  def update
    text = "rolls left: #{3 - @yahtzee.rolls}"
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
    if id == Gosu::KbReturn
      @yahtzee.next_turn
    end
    if id == Gosu::KbSpace
      @yahtzee.reroll
    end
    if id == Gosu::Kb1
      @yahtzee.lock_die(1)
    end
    if id == Gosu::Kb2
      @yahtzee.lock_die(2)
    end
    if id == Gosu::Kb3
      @yahtzee.lock_die(3)
    end
    if id == Gosu::Kb4
      @yahtzee.lock_die(4)
    end
    if id == Gosu::Kb5
      @yahtzee.lock_die(5)
    end

  end
end
