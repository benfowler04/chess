class Piece
    attr_reader :color, :type

    def initialize(color, type)
        @color = color
        @type = type
    end
end