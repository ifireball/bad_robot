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
  describe '#minX' do
    it 'Tells minimum X value' do
      expect(board.minX).to eq(0)
    end
  end
  describe '#minY' do
    it 'Tells minimum Y value' do
      expect(board.minY).to eq(0)
    end
  end
  describe '#maxX' do
    it 'Tells maximum X value' do
      expect(board.maxX).to eq(4)
    end
  end
  describe '#maxY' do
    it 'Tells maximum Y value' do
      expect(board.maxY).to eq(4)
    end
  end
end
