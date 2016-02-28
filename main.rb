require './parser.rb'

if __FILE__ == $0
  board = Board.new(5, 5)
  robot = Robot.new(board)
  parser = Parser.new(robot)
  parser.interact
end
