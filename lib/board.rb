  class Board
  def initialize player
    @player = player
    @rows = initialize_rows
  end
  
  def initialize_rows
    rows = Array.new(10).map!{Array.new(10)}

    add_ships

    (0..9).each do |row|
      (0..9).each do |column|
        rows[row][column] ||= ''
      end
    end
    rows
  end

  def add_ships
    rows[rand(10)][rand(10)]
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
