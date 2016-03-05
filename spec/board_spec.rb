require './board.rb'

describe Board do
  let(:board) { Board.new(5,5) }

  it "Is initialized with size coordinates" do
    expect {
      Board.new(5,5)
    }.not_to raise_error
  end
  describe '#on_board?' do
    it 'Can tell of coodinates are on board or off' do
      [
        [3, 4 ,true], [-1, 2, false], [3, 6, false], [4, 4, true],
      ].each do |x, y, expected|
        expect(board.on_board?(x, y)).to eq(expected)
      end
    end
  end
  describe '#min_x' do
    it 'Tells minimum X value' do
      expect(board.min_x).to eq(0)
    end
  end
  describe '#min_y' do
    it 'Tells minimum Y value' do
      expect(board.min_y).to eq(0)
    end
  end
  describe '#max_x' do
    it 'Tells maximum X value' do
      expect(board.max_x).to eq(4)
    end
  end
  describe '#max_y' do
    it 'Tells maximum Y value' do
      expect(board.max_y).to eq(4)
    end
  end
end
