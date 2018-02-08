class Yahtzee
  attr_reader :rolls

  def initialize
    init_sounds
    init_dice
  end

  def next_turn
    @rolls = 0
    reroll
  end

  def update
    @dice.map(&:update)
  end

  def draw
    @dice.map(&:draw)
  end

  def reroll
    if @rolls < 3
      roll_sound
      @dice.map(&:roll)
      @rolls += 1
    end
  end

  def lock_die(id)
    @dice[id - 1].toggle_lock
  end

  private

  def init_dice
    roll_sound
    @dice = Array.new(5) { Die.new }
    set_dice_position
    @rolls = 1
  end

  def set_dice_position
    @dice.each_with_index do |die, index|
      die.x = die.x + 100 * index # space between each is 100 pixels
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
