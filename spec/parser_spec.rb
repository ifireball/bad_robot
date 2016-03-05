require './parser.rb'

describe Parser do
  let(:board) { Board.new(5,5) }
  let(:robot) { Robot.new(board) }
  let(:parser) { Parser.new(robot) }

  it 'Created with robot arg' do
    expect { Parser.new(robot) }.not_to raise_error
  end

  describe '#robot' do
    it 'Retunrs robot object passed to constructor' do
      expect(parser.robot).to equal robot
    end
  end

  describe '#parse' do
    it 'Can be chained' do
      expect(parser.parse('NORTH')).to equal(parser)
    end
    it 'Parses PLACE x,y,direction to Robot#place' do
      [
        ['PLACE 3,3,NORTH', 3, 3, :north],
        ['PLACE 0,4,EAST', 0, 4, :east],
      ].each do |cmd, expX, expY, expD|
        parser.parse(cmd)
        expect(robot.x).to eq(expX)
        expect(robot.y).to eq(expY)
        expect(robot.direction).to eq(expD)
      end
    end
    it 'Parses LEFT|RIGHT|MOVE to run equivalent methods on robot' do
      [
        ['LEFT', 3, 3, :west],
        ['RIGHT', 3, 3, :east],
        ['MOVE', 3, 4, :north],
      ].each do |cmd, expX, expY, expD|
        robot.place(3, 3, :north)
        parser.parse(cmd)
        expect(robot.x).to eq(expX)
        expect(robot.y).to eq(expY)
        expect(robot.direction).to eq(expD)
      end
    end
    it 'Outputs robot position when REPORT is given' do
      robot.place(3, 4, :north)
      expect {
        parser.parse('REPORT')
      }.to output("3,4,NORTH\n").to_stdout
    end
  end

  describe '#interact' do
    it "Interacts with user to run multipile newline-terminated commands" do
      command_set_examples = [
        ['PLACE 0,0,NORTH', 'MOVE', 'REPORT'],
        ['PLACE 0,0,NORTH', 'LEFT', 'REPORT'],
        ['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE', 'REPORT'],
      ]
      expected_results = [
        ['0,1,NORTH'],
        ['0,0,WEST'],
        ['3,3,NORTH'],
      ]
      command_set_examples.zip(expected_results).each do |command_set, result|
        newline_terminated_commands = command_set.map {|c| "#{c}\n"}.join
        newline_terminated_result = result.map {|r| "#{r}\n"}.join
        input_stream = StringIO.new(newline_terminated_commands)
        output_stream = StringIO.new
        parser = Parser.new(robot, input_stream, output_stream)
        parser.interact
        expect(output_stream.string).to eq(newline_terminated_result)
      end
    end
  end
end
