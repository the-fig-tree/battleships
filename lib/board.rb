class Board
  def initialize player
    @player = player
    @rows = initialize_rows
    add_ships
  end
  
  def initialize_rows
    rows = Array.new(10,'').map!{Array.new(10,'')}
  end

  def value_at(row, column)
    # valid? needs this to return nil for column = -1, not the 10th column
    return nil if column < 0 || row < 0
    rows[row][column] if !rows[row].nil?
  end

  def set_value_at(row, column, val)
    rows[row][column] = val
  end

  def add_ships
    add_ship_of_size(6)
    2.times {add_ship_of_size(4)}
    2.times {add_ship_of_size(3)}
    4.times {add_ship_of_size(2)}
  end
  
  def add_ship_of_size(size)
    generate_valid_ship_position(size).each{|cell| set_value_at(*cell, 's')}
  end

  def generate_valid_ship_position(size)
    loop do
      candidate_cells = generate_ship_position(size)
      return candidate_cells if valid?(candidate_cells)
    end
  end

  def valid?(candidate_cells)
    candidate_cells.each do |cell| 
      # Invalid if any surrounding cell is non-empty
      return false if ![
      value_at(cell[0], cell[1]).to_s,
      value_at(cell[0]+1, cell[1]).to_s,
      value_at(cell[0]-1, cell[1]).to_s,
      value_at(cell[0], cell[1]+1).to_s,
      value_at(cell[0], cell[1]-1).to_s
      ].all?(&:empty?)
    end
    true
  end

  def generate_ship_position(size)
    if rand(2).zero? 
      # horizontal ship
      row, column = rand(10), rand(11-size)
      candidate_cells = (0...size).map{|i| [row, column+i]}
    else
      #vertical ship
      row, column = rand(11-size), rand(10) #starting
      candidate_cells = (0...size).map{|i| [row+i, column]}
    end
  end

  def to_s
    rows.map do |row| 
      row.map do |cell| 
        cell == "" ? "." : cell
      end.join(' ')
    end.join("\n")
  end

  def owner
    @player.name
  end
  
  # This method should register the shot at the coordinates passed
  # hitting a ship or
  # just hitting the water.
  def register_shot(input)
    co_ords = coordinate_parse(input)
    map = {'' => 'o', 's' => 'x'}
    set_value_at(*co_ords, map[value_at(*co_ords)])
  end

  def coordinate_parse(input)
    # A3 -> [2,0]
    column = input.match(/[a-zA-Z]/)[0].upcase.tr("A-J", "0-9").to_i 
    row = input.match(/\d+/)[0].to_i - 1
    [row, column]
  end

  
  # This method returns an array containing 10 arrays with 10 
  # elements each where:
  # - an empty string ('') denotes an empty space in the grid
  # - an 'o' denotes a shot in the water
  # - an 'x' denotes a hit on a ship
  # - an 's' denotes a ship
  # you can change the representations as you please, but make sure
  # that you have
  # four different types
  def rows
    @rows
  end
  
  # This method returns an array containing 10 arrays with 10
  # elements each (as in rows) replacing the ships with an empty
  # string ('') so that your opponent cannot see your ships.
  def opponent_view
    rows.map do |row|
      row.map {|cell| cell == 's' ? '' : cell }
    end
  end
end
