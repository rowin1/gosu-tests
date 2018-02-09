class Scorekeeper
  UPPER_MOVES = [:ones, :twos, :threes, :fours, :fives, :sixes]
  LOWER_MOVES = [:full_house, :small_straight, :large_straight,
                 :three_of_a_kind, :four_of_a_kind, :chance, :yahtzee]

  def initialize(x, y)
    @moves = Hash.new
    (UPPER_MOVES + LOWER_MOVES).each { |move| @moves[move] = Move.new(move)}
    @sprite = Gosu::Image.new($window, Utils.media_path('score.jpg'), false)
    @x = x
    @y = y
  end

  def update
  end

  def draw
    @sprite.draw(@x, @y, 0)
  end

  def total_score
    upper_score_raw + upper_bonus + lower_score
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

  def upper_score_raw
    subtotal(upper_moves)
  end

  def upper_bonus
    upper_score_raw >= 63 ? 35 : 0
  end

  def lower_score
    subtotal(lower_moves)
  end


end
