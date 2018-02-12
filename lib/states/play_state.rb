class PlayState < GameState
  # attr_accessor :object_pool
  def initialize
    @rolls = 3
    @round = 1
    @moves = 1
    @moves_made = 0
    init_sounds
    init_dice
    @scorekeeper = Scorekeeper.new(0, 0)
    @scorekeeper.inform_dice(@dice)
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
    if @round == 13 && @scorekeeper.game_over?
      text = "Game Over! Final Score: #{@scorekeeper.total_score}\nN: New Game"
    else
      text = "Round: #{@round} / 13 - Rolls remaining: #{@rolls}"
    end
    @round_text = Gosu::Image.from_text($window,
      text, Gosu.default_font_name, 30)
  end

  def draw
    @round_text.draw($window.width / 2 - $window.width / 8,
                    $window.height / 2,
                    10)
    @dice.each(&:draw)
    @scorekeeper.draw
  end

  def button_down(id)
    $window.close if id == Gosu::KbQ
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
    if id == Gosu::KbReturn
      next_turn
    end
    if id == Gosu::KbSpace
      reroll
      @scorekeeper.inform_dice(@dice)
    end
    if id == Gosu::KbN
      play_state = PlayState.new
      MenuState.instance.play_state = play_state
      GameState.switch(play_state)
    end
    if id == Gosu::Kb1
      lock_die(1)
    end
    if id == Gosu::Kb2
      lock_die(2)
    end
    if id == Gosu::Kb3
      lock_die(3)
    end
    if id == Gosu::Kb4
      lock_die(4)
    end
    if id == Gosu::Kb5
      lock_die(5)
    end
    if id == Gosu::MsLeft
      handle_click
    end
  end

  private

  def handle_click
    if moves_left?
      @scorekeeper.handle_click
      if @moves_made != @scorekeeper.moves_made
        @moves_made += 1
        @moves = 0
      end
    else
      puts "No moves left for this round. Hit enter."
    end
  end

  def moves_left?
    @moves > 0
  end

  def next_turn
    if @round < 13 && @moves == 0
      @round +=1
      @rolls = 3
      @moves = 1
      reroll
    elsif @moves > 0
      puts "Must score a category."
    end
  end

  def reroll
    if @rolls > 0
      roll_sound
      @dice.map(&:roll)
      @rolls -= 1
    end
  end

  def lock_die(id)
    @dice[id - 1].toggle_lock
  end

  def init_dice
    roll_sound
    @dice = Array.new(5) { Die.new }
    set_dice_position($window.width / 2 - $window.width / 8, 2 * $window.height / 6)
    @rolls -= 1
  end

  def set_dice_position(left_x, all_y)
    @dice.each_with_index do |die, index|
      die.x = left_x + $window.width / 8 * index # space between each is 100 pixels
      die.y = all_y
    end
  end

  def init_sounds
    @dice_sounds = Array.new(3)
    @dice_sounds[0] = Gosu::Sample.new($window, Utils.media_path('dieThrow1.wav'))
    @dice_sounds[1] = Gosu::Sample.new($window, Utils.media_path('dieThrow2.wav'))
    @dice_sounds[2] = Gosu::Sample.new($window, Utils.media_path('dieThrow3.wav'))
  end

  def roll_sound
    @dice_sounds[Random::rand(3)].play
  end
end
