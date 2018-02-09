class Move

  attr_reader :score, :move_type

  def initialize(move_type)
    @move_type = move_type
  end

  def make(dice)
    send(@move_type,dice)
  end

  def make_and_score(dice)
    if @score
      puts "#{@move_type} FAILED. Already filled."
      puts "-------"
    else
      @score = send(@move_type, dice)
      puts "Move made: #{@move_type}"
      puts "Points: #{@score}"
      puts "Tell Yahtzee class to advance turn"
      puts "-------"
    end
  end

  private

  def ones(dice)
    sum_for(1, dice)
  end

  def twos(dice)
    sum_for(2, dice)
  end

  def threes(dice)
    sum_for(3, dice)
  end

  def fours(dice)
    sum_for(4, dice)
  end

  def fives(dice)
    sum_for(5, dice)
  end

  def sixes(dice)
    sum_for(6, dice)
  end

  def full_house(dice)
    dice.uniq{|die| die.number}.size == 2 ? 25 : 0
  end

  def small_straight(dice)
    sorted_dice = dice.uniq{|die| die.number }.sort_by {|die| die.number }.map{|die| die.number }
    sorted_dice[0..3] == [1, 2, 3, 4] || sorted_dice[0..3] == [2, 3, 4, 5] || sorted_dice[1..4]== [3, 4, 5, 6] ? 30 : 0
  end

  def large_straight(dice)
    sorted_dice = dice.sort_by {|die| die.number}.map{|die| die.number}
    [[1,2,3,4,5], [2,3,4,5,6]].include?(sorted_dice) ? 40 : 0
  end

  def three_of_a_kind(dice)
    # implement
  end

  def four_of_a_kind(dice)
    # implement
  end

  def chance(dice)
    sum(dice)
  end

  def yahtzee(dice)
    dice.uniq{|die| die.number}.size == 1 ? 50 : 0
  end

  def sum_for(target, dice)
    sum = 0
    dice.each do |die|
      if die.number == target
        sum += target
      end
    end
    sum
    # dice.select{ |die| die.number == target }.inject(0) {|sum, die| sum + die.number}
  end

  def sum(dice)
    dice.inject(0) { |result, die| result + die.number }
  end
end
