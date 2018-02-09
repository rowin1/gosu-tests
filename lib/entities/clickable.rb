class Clickable
  attr_reader :left, :bottom, :right, :top, :width, :height, :move_type

  def initialize(left, top, width, height, move_type)
    @width = width
    @height = height
    @left = left
    @top = top
    @bottom = top + height
    @right = left + width
    @move_type = move_type
  end

  def clicked?
    collide?($window.mouse_x, $window.mouse_y)
  end

  def collide?(x, y)
    x >= left && x <= right && y <= bottom && y >= top
  end
end
