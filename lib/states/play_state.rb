class PlayState < GameState
  # attr_accessor :object_pool
  def initialize
    @yahtzee = Yahtzee.new
    @scorekeeper = Scorekeeper.new(0, 0)
    @scorekeeper.inform_dice(@yahtzee.dice)
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
    if @yahtzee.round == 13 && @yahtzee.rolls == 0
      text = "Game Over! Final Score: #{@scorekeeper.total_score}\nN: New Game"
    else
      text = "Round: #{@yahtzee.round} / 13 - Rolls remaining: #{@yahtzee.rolls}"
    end
    @round_text = Gosu::Image.from_text($window,
      text, Gosu.default_font_name, 30)
  end

  def draw
    @round_text.draw($window.width / 2 - $window.width / 8,
                    $window.height / 2,
                    10)
    @yahtzee.draw
    @scorekeeper.draw
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
      @scorekeeper.inform_dice(@yahtzee.dice)
    end
    if id == Gosu::KbN
      play_state = PlayState.new
      MenuState.instance.play_state = play_state
      GameState.switch(play_state)
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
    if id == Gosu::MsLeft
      @scorekeeper.handle_click
    end
  end
end
