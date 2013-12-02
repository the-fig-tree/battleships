require 'player'

describe Player do 

  let(:player) {Player.new("jim")}

  it 'should have a name' do
    expect(player.name).to eq("jim")
  end


  it 'should have board' do 
    expect(player.board).to eq("board")
  end

  it 'should know if there are still floating ships' do
    expect(player.has_ships_still_floating?).to be_true
  end
  


end