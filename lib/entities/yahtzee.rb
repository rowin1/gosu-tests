class Yahtzee
  attr_reader :rolls

  def initialize
    @dice = Array.new(5) { Die.new }
    set_dice_position
    @rolls = 0
  end

  def update
    @dice.map(&:update)
  end

  def draw
    @dice.map(&:draw)
  end

  def reroll
    @dice.map(&:roll)
    @rolls += 1
  end

  def lock_die(id)
    @dice[id - 1].toggle_lock
  end

  private

  def set_dice_position
    @dice.each_with_index do |die, index|
      die.x = die.x + 100 * index # space between each is 100 pixels
    end
  end
end
