require './board.rb'

class Robot
  DIRECTIONS=%w{north west south east}.map(&:to_sym)

  def initialize(board)
    @board = board
    @x = nil
    @y = nil
    @direction = nil
  end
  attr_reader :x, :y
  def direction
    DIRECTIONS[@direction] if @direction
  end
  def place(x, y, direction)
    new_direction = DIRECTIONS.index(direction.to_sym())
    if @board.on_board?(x, y) && new_direction
      @x = x
      @y = y
      @direction = new_direction
    end
    return self
  end
  def left
    @direction = (@direction + 1) % DIRECTIONS.length if @direction
    return self
  end
  def right
    @direction = (@direction - 1) % DIRECTIONS.length if @direction
    return self
  end
  def move_north
    place(x, y + 1, direction) if @y
    return self
  end
  def move_south
    place(x, y - 1, direction) if @y
    return self
  end
  def move_east
    place(x + 1, y, direction) if @x
    return self
  end
  def move_west
    place(x - 1, y, direction) if @x
    return self
  end
  def move
    send("move_#{direction}") if @direction
    return self
  end
end
