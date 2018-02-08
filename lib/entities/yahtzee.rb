class Yahtzee
  attr_reader :rolls, :round

  def initialize
    @rolls = 3
    @round = 1
    init_scorekeeper
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

  def make_move(id)
    @scorekeeper.make_move(@dice, id)
  end

  def score
    # Implement
    @score = 1337
  end

  private

  def init_scorekeeper
    @scorekeeper = Scorekeeper.new
  end

  def init_dice
    roll_sound
    @dice = Array.new(5) { Die.new }
    set_dice_position
    @rolls -= 1
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
