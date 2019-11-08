require './lib/piece'

RSpec.describe Piece do
    describe "#initialize" do
        before(:each) do
            @piece = Piece.new("white", "king")
        end
        it "returns the piece's color" do
            expect(@piece.color).to eql("white")
        end
        it "returns the piece's type" do
            expect(@piece.type).to eql("king")
        end
    end

    describe "#set_symbol" do
        it "sets the piece's symbol" do
            piece = Piece.new("white", "king")
            expect(piece.symbol).to eql("\u265a")
        end
    end
end