require './robot.rb'

describe Robot do
  let(:board) { Board.new(5,5) }
  let(:robot) { Robot.new(board) }
  let(:placed_robot) { Robot.new(board).place(3, 3, :north) }

  it "Initializes with board arg" do
    expect {
      Robot.new(board)
    }.not_to raise_error
  end

  describe '#place' do
    it "Can be called with X,Y and direction" do
      %w{north south east west}.each do |direction|
        [direction, direction.to_sym()].each do |dirf|
          robot.place(3, 3, dirf)
        end
      end
    end
    it "Can be chained" do
      expect(robot.place(1,1, :north)).to equal(robot)
    end
  end

  describe '#x' do
    it "Show robot X position set by #place" do
      board.minX.upto(board.maxX) do |x|
        expect(robot.place(x, 3, :north).x).to eq(x)
      end
    end
    it "Returns nil until place is called"  do
      expect(robot.x).to eq(nil)
    end
    it "Remains in board" do
      [3, -3, 7].each do |x|
        robot.place(x, 3, :north)
        expect(robot.x).to eq(3)
      end
    end
  end

  describe '#y' do
    it "Show robot Y position set by #place" do
      board.minY.upto(board.maxY) do |y|
        expect(robot.place(y, 3, :north).y) == y
      end
    end
    it "Return nil until place is called"  do
      expect(robot.y).to eq(nil)
    end
    it "Remains in board" do
      [3, -3, 7].each do |y|
        robot.place(3, y, :north)
        expect(robot.y).to eq(3)
      end
    end
  end

  describe '#direction' do
    it "Show robot direction set by #place" do
      %w{north south east west}.each do |direction|
        [direction, direction.to_sym()].each do |dirf|
          expect(robot.place(3, 3, dirf).direction).to eq(dirf.to_sym)
        end
      end
    end
    it 'Is nil until place is called' do
      expect(robot.direction).to eq(nil)
    end
    it 'Remains legal direction' do
      %w{blah foo no_such}.each do |bad_direction|
        expect(placed_robot.place(3, 3, bad_direction).direction).to eq(:north)
      end
    end
  end

  describe '#left' do
    it 'Can be chained' do
      expect(placed_robot.left).to equal(placed_robot)
    end
    it 'Makes the robot turn left' do
      %w{west south east north}.each do |expected|
        expect(placed_robot.left.direction).to eq(expected.to_sym)
      end
    end
    it 'Does not work before place is called' do
      expect(robot.left.direction).to eq(nil)
    end
  end

  describe '#right' do
    it 'Can be chained' do
      expect(placed_robot.right).to equal(placed_robot)
    end
    it 'Makes the robot turn right' do
      %w{east south west north}.each do |expected|
        expect(placed_robot.right.direction).to eq(expected.to_sym)
      end
    end
    it 'Does not work before place is called' do
      expect(robot.right.direction).to eq(nil)
    end
  end

  describe '#move_north' do
    it 'Can be chained' do
      expect(placed_robot.move_north).to equal(placed_robot)
    end
    it 'Makes robot walk north, and stays on board' do
      [[3, 4], [3, 4]].each do |expX, expY|
        placed_robot.move_north
        expect(placed_robot.x).to eq(expX)
        expect(placed_robot.y).to eq(expY)
      end
    end
  end
  describe '#move_south' do
    it 'Can be chained' do
      expect(placed_robot.move_south).to equal(placed_robot)
    end
    it 'Makes robot walk south, and stays on board' do
      [[3, 2], [3, 1], [3, 0], [3, 0]].each do |expX, expY|
        placed_robot.move_south
        expect(placed_robot.x).to eq(expX)
        expect(placed_robot.y).to eq(expY)
      end
    end
  end
  describe '#move_east' do
    it 'Can be chained' do
      expect(placed_robot.move_east).to equal(placed_robot)
    end
    it 'Makes robot walk east, and stays on board' do
      [[4, 3], [4, 3]].each do |expX, expY|
        placed_robot.move_east
        expect(placed_robot.x).to eq(expX)
        expect(placed_robot.y).to eq(expY)
      end
    end
  end
  describe '#move_west' do
    it 'Can be chained' do
      expect(placed_robot.move_west).to equal(placed_robot)
    end
    it 'Makes robot walk west, and stays on board' do
      [[2, 3], [1, 3], [0, 3], [0, 3]].each do |expX, expY|
        placed_robot.move_west
        expect(placed_robot.x).to eq(expX)
        expect(placed_robot.y).to eq(expY)
      end
    end
  end
  describe '#move' do
    it 'Can be chained' do
      expect(placed_robot.move).to equal(placed_robot)
    end
    it 'moves the robot in the direction its facing' do
      [
        [2, 2, :north, 2, 3, :north],
        [2, 2, :south, 2, 1, :south],
        [2, 2, :east, 3, 2, :east],
        [2, 2, :west, 1, 2, :west],
      ].each do |plX, plY, plD, expX, expY, expD|
        robot.place(plX, plY, plD).move
        expect(robot.x).to eq(expX)
        expect(robot.y).to eq(expY)
        expect(robot.direction).to eq(expD)
      end
    end
  end
end

