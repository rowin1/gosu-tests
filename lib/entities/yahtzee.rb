class Yahtzee
  attr_reader :rolls, :round, :dice

  def initialize
    @rolls = 3
    @round = 1
    init_sounds
    init_dice
  end

  def next_turn
    if @round < 13
      @round +=1
      @rolls = 3
      reroll
    end
  end

  def update
    @dice.map(&:update)
  end

  def draw
    @dice.map(&:draw)
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

  private

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
