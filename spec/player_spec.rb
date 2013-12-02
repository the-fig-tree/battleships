require 'player'

describe Player do 

  let(:player) {Player.new("jim")}

  it 'should have a name' do
    expect(player.name).to eq("jim")
  end


  it 'should have board' do 
    expect(player.board).to be_a(Board)
  end

  it 'should say there are floating ships if there are' do
    player.board.stub(:rows){[['','s','s','']]}
    expect(player.has_ships_still_floating?).to be_true
  end
  
  it 'should say there are not still floating ships if there aren\'t' do
    player.board.stub(:rows){[['o','x','','']]}
    expect(player.has_ships_still_floating?).to be_false
  end
  


end