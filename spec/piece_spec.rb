require './lib/piece'

RSpec.describe Piece do
    describe "#initialize" do
        it "returns the piece's color" do
            piece = Piece.new("white", "king")
            expect(piece.color).to eql("white")
        end
        it "returns the piece's type" do
            piece = Piece.new("white", "king")
            expect(piece.type).to eql("king")
        end
    end
end