require './parser.rb'

def main
  board = Board.new(5, 5)
  robot = Robot.new(board)
  parser = Parser.new(robot)
  parser.interact
end

main
