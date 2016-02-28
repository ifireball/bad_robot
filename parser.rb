require './robot.rb'

class Parser
  def initialize(robot, stdin=$stdin, stdout=$stdout)
    @robot = robot
    @stdin = stdin
    @stdout = stdout
  end
  attr_reader :robot
  def parse(cmd)
    case cmd
    when /\APLACE (\d+),(\d+),(NORTH|SOUTH|EAST|WEST)\z/
      robot.place($1.to_i, $2.to_i, $3.downcase)
    when /\A(LEFT|RIGHT|MOVE)\z/
      robot.send($1.downcase)
    when 'REPORT'
      robot.direction and
        @stdout.puts "#{robot.x},#{robot.y},#{robot.direction.to_s.upcase}"
    end
    return self
  end
  def interact
    @stdin.each_line do |line|
      parse(line.chomp)
    end
  end
end

if __FILE__ == $0
  board = Board.new(5, 5)
  robot = Robot.new(board)
  parser = Parser.new(robot)
  parser.interact
end
