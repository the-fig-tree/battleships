require_relative '../lib/board'

describe Board do

  it 'should create an empty board on initializing' do
    player = double :player

    board = Board.new(player)
    expect(board.rows).to eq [(['']*10)]*10  
  end

end