class Player
    attr_reader :name, :piece_color

    def initialize(name, piece_color)
        @name = name
        @piece_color = piece_color
    end
end