class Player
    attr_reader :name, :piece_color
    attr_accessor :check_status

    def initialize(name, piece_color)
        @name = name
        @piece_color = piece_color
        @check_status = false
    end
end