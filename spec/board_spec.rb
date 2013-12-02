require 'board'

describe Board do

  context 'initialization' do    

    it 'should create a board on initializing' do
      player = double :player
      board = Board.new(player)
      expect(board.rows.length).to eq 10  
      expect(board.rows[0].length).to eq 10  
    end

    it 'should have 28 ship squares and 72 empty squares' do
      player = double :player
      board = Board.new(player)
      expect(board.rows.flatten.select{|c| c == 's'}.count).to eq 28
      expect(board.rows.flatten.select{|c| c == ''}.count).to eq 72
    end

    it 'should generate 6 cells in a row, each with two coordinates' do
      player = double :player
      board = Board.new(player)
      expect(board.generate_ship_position(6).length).to eq(6)
      expect(board.generate_ship_position(6)[0].length).to eq(2)
    end  

    it 'should not put two ships next to each other' do
      player = double :player
      board = Board.new(player)
      board.iterate_board_index do |row, column|
        if board.value_at(row, column) == 's'
          if board.value_at(row+1, column) == 's' || board.value_at(row-1, column) =='s'
            # could be nil if at edge, nil.to_s == '' 
            expect(board.value_at(row, column+1).to_s).to eq ''
            expect(board.value_at(row, column-1).to_s).to eq ''
          elsif board.value_at(row, column+1) == 's' || board.value_at(row, column-1) =='s'
            # could be nil if at edge, nil.to_s == '' 
            expect(board.value_at(row+1, column).to_s).to eq ''
            expect(board.value_at(row-1, column).to_s).to eq ''
          end
        end
      end
    end
  end
  
  context "should convert coordinates to indexs" do
    it "should convert A3 to [2,0]" do
      player = double :player
      board = Board.new(player)
      expect(board.coordinate_parse("A3")).to eq([2,0])
    end

    it "should convert b 6 to [5,1]" do
      player = double :player
      board = Board.new(player)
      expect(board.coordinate_parse("b 6")).to eq([5,1])
    end
  end

  context "playing battleships" do

    it 'should register a shot in water with a o' do
      player = double :player
      board = Board.new(player)
      # Need to set @rows since 
      # board.stub(:rows){[['o','x','s','']]}
      # can't be modified - it seems to be reevaluated
      # every time rows is called
      board.instance_variable_set(:@rows,[['o','x','s','']])
      board.register_shot("D1")
      expect(board.rows).to eq([['o','x','s','o']])
    end

    it 'should register a shot on a ship with an x' do
      player = double :player
      board = Board.new(player)
      board.instance_variable_set(:@rows,[['o','x','s','']])
      board.register_shot("C1")
      expect(board.rows).to eq([['o','x','x','']])
    end

    it "opponent view should not show ships" do
      player = double :player
      board = Board.new(player)
      board.instance_variable_set(:@rows,[['o','x','s','']])
      expect(board.opponent_view).to eq([['o','x','','']])
    end

  end

  it 'should be able to set the value of a cell' do
    player = double :player
    board = Board.new(player)
    board.instance_variable_set(:@rows,[['old']])
    board.set_value_at(0, 0, 'new')
    expect(board.value_at(0, 0)).to eq('new')
  end

end