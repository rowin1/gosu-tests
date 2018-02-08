class Scorekeeper
  UPPER_MOVES = [:ones, :twos, :threes, :fours, :fives, :sixes]
  LOWER_MOVES = [:full_house, :small_straight, :large_straight,
                 :three_of_a_kind, :four_of_a_kind, :chance, :yahtzee]

  def initialize
    @moves = Hash.new
    (UPPER_MOVES + LOWER_MOVES).each { |move| @moves[move] = Move.new(move)}
  end

  def total_score
    subtotal(upper_moves) + subtotal(lower_moves)
  end

  def make_move(dice, id)
    @moves[id].make(dice)
    puts "Move made: #{@moves[id].move_type}, Points: #{score_move(id)}"
    puts "Total Score: #{total_score}"
  end

  def score_move(move)
    @moves[move].score
  end

  private

  def upper_moves
    @moves.select {|name, move| UPPER_MOVES.include? name}
  end

  def lower_moves
    @moves.select {|name, move| LOWER_MOVES.include? name}
  end

  def subtotal(move_set)
    move_set.map {|name, move| move.score}.inject(0){|total, val| total + (val.nil? ? 0 : val)}
  end

end
