class Board
  def initialize player
    @player = player
    @rows = initialize_rows
    add_ships
  end
  
  def initialize_rows
    rows = Array.new(10).map!{Array.new(10)}

    (0..9).each do |row|
      (0..9).each do |column|
        rows[row][column] ||= ''
      end
    end
    rows
  end

  def value_at(row, column)
    rows[row][column]
  end

  def add_ships
    add_ship_of_size(6)
    2.times {add_ship_of_size(4)}
    2.times {add_ship_of_size(3)}
    4.times {add_ship_of_size(2)}
  end
  
  def add_ship_of_size(size)
    generate_valid_ship_position(size).each{|cell| rows[cell[0]][cell[1]] = 's'}
  end

  def generate_valid_ship_position(size)
    loop do
      candidate_cells = generate_ship_position(size)
      return candidate_cells if valid?(candidate_cells)
    end
  end

  def valid?(candidate_cells)
    candidate_values = candidate_cells.map{|coords| value_at(coords[0], coords[1])}
    candidate_values.all?{|value| value == ''} # and not touching other ships
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

  def owner
    @player.name
  end
  
  # This method should register the shot at the coordinates passed
  # hitting a ship or
  # just hitting the water.
  def register_shot at_coordinates  
  
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
  end
end
