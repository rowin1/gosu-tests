class Die
  attr_reader :number
  attr_accessor :x

  def initialize
    @x = 50
    @locked = false
    roll
  end

  def roll
    if !@locked
      @number = Random::rand(6) + 1
      @sprite = dice_sprite
    else
      toggle_lock
    end
  end

  def toggle_lock
    @locked = !@locked
  end

  def to_s
    @number
  end

  def update
  end

  def draw
    @sprite.draw(@x, $window.height / 2, 0)
  end

  private

  def dice_sprite
    sprites = Gosu::Image.load_tiles($window, Utils.media_path('dice.png'), 32, 32, false)
    sprites[@number - 1]
  end

end
