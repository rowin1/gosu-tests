class GameWindow < Gosu::Window
  attr_accessor :state, :debug
  attr_reader :click_x, :click_y

  def initialize
    super(800, 600, false)
    $window = self
    @debug = false
  end

  def update
    update_caption
    @state.update
  end

  def draw
    @state.draw
  end

  def needs_redraw?
    @state.needs_redraw?
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if id == Gosu::MsLeft
      @click_x = self.mouse_x
      @click_y = self.mouse_y
    end
    @state.button_down(id)
  end

  private

  def update_caption
    if @debug
      self.caption = "Mouse click: #{self.click_x}, #{self.click_y}"
    else
      self.caption = "YAHTZEE"
    end
  end
end
