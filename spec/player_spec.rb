require './lib/player'

RSpec.describe Player do
    describe "#initialize" do
        it "returns the player's name" do
            player = Player.new("Ben", "white")
            expect(player.name).to eql("Ben")
        end
        it "returns the color of the player's pieces" do
            player = Player.new("Ben", "white")
            expect(player.piece_color).to eql("white")
        end
    end
end