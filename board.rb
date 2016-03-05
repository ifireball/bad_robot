class Board
  def initialize(w, h)
    @w = w
    @h = h
  end
  def on_board?(x, y)
    x.between?(min_x, max_x) and y.between?(min_y, max_y)
  end
  def min_x
    0
  end
  def max_x
    @w - 1
  end
  def min_y
    0
  end
  def max_y
    @h - 1
  end
end
