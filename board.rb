class Board
  def initialize(w, h)
    @w = w
    @h = h
  end
  def on_board?(x, y)
    x.between?(minX, maxX) and y.between?(minY, maxY)
  end
  def minX
    0
  end
  def maxX
    @w - 1
  end
  def minY
    0
  end
  def maxY
    @h - 1
  end
end
