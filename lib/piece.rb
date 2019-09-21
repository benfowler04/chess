class Piece
    attr_reader :color, :type, :symbol

    def initialize(color, type)
        @color = color
        @type = type
        @symbol = set_symbol(color, type)
    end

    def set_symbol(color, type)
        if color == "white"
            return "\u265a" if type == "king"
            return "\u265b" if type == "queen"
            return "\u265c" if type == "rook"
            return "\u265d" if type == "bishop"
            return "\u265e" if type == "knight"
            return "\u265f" if type == "pawn"
        else
            return "\u2654" if type == "king"
            return "\u2655" if type == "queen"
            return "\u2656" if type == "rook"
            return "\u2657" if type == "bishop"
            return "\u2658" if type == "knight"
            return "\u2659" if type == "pawn"
        end
    end
end