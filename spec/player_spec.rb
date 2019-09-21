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
        it "returns the correct check status for the player" do
            player = Player.new("Ben", "white")
            expect(player.check_status).to eql(false)
        end
    end
end