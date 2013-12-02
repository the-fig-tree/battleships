require_relative '../lib/board'

describe Board do

  context 'initialization' do    

    it 'should create a board on initializing' do
      player = double :player
      board = Board.new(player)
      expect(board.rows.length).to eq 10  
      expect(board.rows[0].length).to eq 10  
    end

    xit 'should have 28 ship squares and 73 empty squares' do
      player = double :player
      board = Board.new(player)
      expect(board.rows.flatten.select{|c| c == 's'}.count).to eq 28
      expect(board.rows.flatten.select{|c| c == ''}.count).to eq 72
    end

    it 'should have 6 s values in a row after adding aircraft carrier' do
      player = double :player
      board = Board.new(player)
      # board.add_ships
      expect(board.rows.flatten.select{|c| c == 's'}.count).to eq 6
    end

    it 'should generate a valid ship position' do
      player = double :player
      board = Board.new(player)
      expect(board.valid?(board.generate_valid_ship_position)).to be_true
    end

    xit 'should not put two ships next to each other' do
      player = double :player
      board = Board.new(player)
      (0..9).each do |row|
        (0..9).each do |column|
          if board.rows[row][column] == 's'
            if board.rows[row+1][column] == 's' || board.rows[row-1][column] =='s'
              # could be nil if at edge, nil.to_s == '' 
              expect(board.rows[row][column+1].to_s).to eq ''
              expect(board.rows[row][column-1].to_s).to eq ''
            end
          end
        end
      end
    end

  end


end