require 'player'

describe Player do 

  let(:player) {Player.new("jim", "winner's board")}

  it 'should have a name' do
    expect(player.name).to eq("jim")
  end

  it 'should have a board' do   
    expect(player.board).to eq("winner's board")
  end



end