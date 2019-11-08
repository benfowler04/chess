require './lib/player'

RSpec.describe Player do
    describe "#initialize" do
        before(:each) do
            @player = Player.new("Ben", "white")
        end
        it "returns the player's name" do
            expect(@player.name).to eql("Ben")
        end
        it "returns the color of the player's pieces" do
            expect(@player.piece_color).to eql("white")
        end
        it "returns the correct check status for the player" do
            expect(@player.check_status).to eql(false)
        end
    end
end