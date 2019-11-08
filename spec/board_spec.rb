require './lib/board'

RSpec.describe Board do
    describe "#initialize" do
        before(:each) do
            @board = Board.new
        end
        it "creates 8 columns" do
            expect(@board.current_state.length).to eql(8)
        end
        it "creates 8 rows" do
            expect(@board.current_state[0].length).to eql (8)
        end
    end

    describe "#is_valid_start?" do
        before(:each) do
            @board = Board.new
            $stdout = File.open(File::NULL, "w")
        end
        it "returns false if column is out of bounds" do
            expect(@board.is_valid_start?("91", "white")).to eql(false)
        end
        it "returns false if row is out of bounds" do
            expect(@board.is_valid_start?("10", "white")).to eql(false)
        end
        it "returns false if there is no piece at the position" do
            expect(@board.is_valid_start?("14", "white")).to eql(false)
        end
        it "returns false if the piece at the position is the other player's" do
            expect(@board.is_valid_start?("17", "white")).to eql(false)
        end
        it "returns false if the piece has no valid moves" do
            expect(@board.is_valid_start?("11", "white")).to eql(false)
        end
        it "returns false if the piece has no valid moves due to check" do
            @board.move_piece("32", "34")
            @board.move_piece("47", "45")
            @board.move_piece("41", "14")
            expect(@board.is_valid_start?("87", "black")).to eql(false)
        end
        it "returns true if the piece has at least one valid move" do
            expect(@board.is_valid_start?("12", "white")).to be_truthy
        end
    end

    describe "#is_valid_end?" do
        before(:each) do
            @board = Board.new
        end
        it "returns false if column is out of bounds" do
        end
        it "returns false if row if out of bounds" do
        end
        it "returns false if start and end position are the same" do
        end
        it "returns false if one of the player's own pieces is in the end position" do
        end
        it "returns false if the move would put your own king in check" do
        end
        it "returns true if a king moves one space horizontally" do
        end
        it "returns true if a king moves one space vertically" do
        end
        it "returns true if a king moves one space diagonally" do
        end
        it "returns false if a king tries to move two spaces horizontally" do
        end
        it "returns false if a king tries to move two spaces horizontally" do
        end
        it "returns false if a king tries to move two spaces diagonally" do
        end
        it "returns true if a queen moves horizontally" do
        end
        it "returns true if a queen moves vertically" do
        end
        it "returns true if a queen moves diagonally" do
        end
        it "returns false if a queen tries to move horizontally and another piece is in the way" do
        end
        it "returns false if a queen tries to move vertically and another piece is in the way" do
        end
        it "returns false if a queen tries to move diagonally and another piece is in the way" do
        end
        it "returns true if a knight moves two columns and one row" do
        end
        it "returns true if a knight moves one column and two rows" do
        end
        it "returns false if a knight tries to move three spaces in a straight line" do
        end
        it "returns true if a bishop moves diagonally" do
        end
        it "returns false if a bishop tries to move horizontally" do
        end
        it "returns false if a bishop tries to move vertically" do
        end
        it "returns false if a bishop tries to move diagonally up and right and another piece is in the way" do
        end
        it "returns false if a bishop tries to move diagonally down and right and another piece is in the way" do
        end
        it "returns false if a bishop tries to move diagonally down and left and another piece is in the way" do
        end
        it "returns false if a bishop tries to move diagonally up and left and another piece is in the way" do
        end
        it "returns true if a rook moves horizontally" do
        end
        it "returns true if a rook moves vertically" do
        end
        it "returns false if a rook tries to move diagonally" do
        end
        it "returns false if a rook tries to move horizontally and another piece is in the way" do
        end
        it "returns false if a rook tries to move vertically and another piece is in the way" do
        end
        it "returns true if a white pawn moves forward one space" do
        end
        it "returns true if a white pawn that hasn't moved yet moves forward two spaces" do
        end
        it "returns false if a white pawn that has already moved tries to move forward two spaces" do
        end
        it "returns false if a white pawn tries to move two forward and another piece is in the way" do
        end
        it "returns true if a white pawn captures another piece diagonally" do
        end
        it "returns false if a white pawn tries to move diagonally when not capturing another piece" do
        end
        it "returns false if a white pawn tries to move backward" do
        end
        it "returns false if a white pawn tries to capture a piece on the row behind it diagonally" do
        end
        it "returns false if a white pawn tries to move forward three spaces" do
        end
        it "returns false if a white pawn tries to capture another piece two spaces away diagonally" do
        end
        it "returns true if a black pawn moves forward one space" do
        end
        it "returns true if a black pawn that hasn't moved yet moves forward two spaces" do
        end
        it "returns false if a black pawn that has already moved tries to move forward two spaces" do
        end
        it "returns false if a black pawn tries to move two forward and another piece is in the way" do
        end
        it "returns true if a black pawn captures another piece diagonally" do
        end
        it "returns false if a black pawn tries to move diagonally when not capturing another piece" do
        end
        it "returns false if a black pawn tries to move backward" do
        end
        it "returns false if a black pawn tries to capture a piece on the row behind it diagonally" do
        end
        it "returns false if a black pawn tries to move forward three spaces" do
        end
        it "returns false if a black pawn tries to capture another piece two spaces away diagonally" do
        end
    end

    describe "#move_piece" do
        before(:each) do
            @board = Board.new
        end
        it "moves the piece" do
        end
        it "removes a captured piece from the board" do
        end
        it "promotes a pawn that reaches the other end of the board" do
        end
        it "returns 0 if the game should continue" do
        end
        it "returns 1 if the move puts the other player's king in check" do
        end
        it "returns 2 if the move puts the other player's king in checkmate" do
        end
    end

    describe "#show_board" do
        before(:each) do
            @board = Board.new
        end
        it "shows the starting board" do
            expect{@board.show_board}.to output("\u2656\u2658\u2657\u2655\u2654\u2657\u2658\u2656\n"\
                                                "\u2659\u2659\u2659\u2659\u2659\u2659\u2659\u2659\n"\
                                                "        \n"\
                                                "        \n"\
                                                "        \n"\
                                                "        \n"\
                                                "\u265f\u265f\u265f\u265f\u265f\u265f\u265f\u265f\n"\
                                                "\u265c\u265e\u265d\u265b\u265a\u265d\u265e\u265c\n").to_stdout
        end
        it "shows the updated board after a move has been made" do
            @board.move_piece("82", "84")
            expect{@board.show_board}.to output("\u2656\u2658\u2657\u2655\u2654\u2657\u2658\u2656\n"\
                                                "\u2659\u2659\u2659\u2659\u2659\u2659\u2659\u2659\n"\
                                                "        \n"\
                                                "        \n"\
                                                "       \u265f\n"\
                                                "        \n"\
                                                "\u265f\u265f\u265f\u265f\u265f\u265f\u265f \n"\
                                                "\u265c\u265e\u265d\u265b\u265a\u265d\u265e\u265c\n").to_stdout
        end
    end
end