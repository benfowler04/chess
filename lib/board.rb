require './lib/piece'

class Board
    attr_reader :current_state

    def initialize
        @current_state = Array.new(8){Array.new(8, "")}
        @current_state[0][0] = Piece.new("white", "rook")
        @current_state[1][0] = Piece.new("white", "knight")
        @current_state[2][0] = Piece.new("white", "bishop")
        @current_state[3][0] = Piece.new("white", "queen")
        @current_state[4][0] = Piece.new("white", "king")
        @current_state[5][0] = Piece.new("white", "bishop")
        @current_state[6][0] = Piece.new("white", "knight")
        @current_state[7][0] = Piece.new("white", "rook")
        @current_state[0][7] = Piece.new("black", "rook")
        @current_state[1][7] = Piece.new("black", "knight")
        @current_state[2][7] = Piece.new("black", "bishop")
        @current_state[3][7] = Piece.new("black", "queen")
        @current_state[4][7] = Piece.new("black", "king")
        @current_state[5][7] = Piece.new("black", "bishop")
        @current_state[6][7] = Piece.new("black", "knight")
        @current_state[7][7] = Piece.new("black", "rook")
        for column in 0..7
            @current_state[column][1] = Piece.new("white", "pawn")
            @current_state[column][6] = Piece.new("black", "pawn")
        end
    end

    def is_valid_start?(position, color)
        column = position[0].to_i - 1
        row = position[1].to_i - 1
        unless position.length == 2 && (0..7).include?(column) && (0..7).include?(row)
            puts "#{position} is not a valid position."
            return false
        end
        if @current_state[column][row] == ""
            puts "There is no piece at #{position}."
            return false
        end
        unless @current_state[column][row].color == color
            puts "The piece at #{position} isn't yours!"
            return false
        end
        unless has_valid_move?(column, row)
            puts "The piece at #{position} has no valid moves."
            return false
        end
        return @current_state[column][row].type
    end

    def is_valid_end?(start_position, end_position, color, piece_type, skip_puts = false)
        end_column = end_position[0].to_i - 1
        end_row = end_position[1].to_i - 1
        unless end_position.length == 2 && (0..7).include?(end_column) && (0..7).include?(end_row)
            puts "#{end_position} is not a valid position." unless skip_puts
            return false
        end
        if start_position == end_position
            puts "The piece is already at #{end_position}." unless skip_puts
            return false
        end
        if @current_state[end_column][end_row] != "" && @current_state[end_column][end_row].color == color
            puts "One of your pieces is already at #{end_position}." unless skip_puts
            return false
        end
        start_column = start_position[0].to_i - 1
        start_row = start_position[1].to_i - 1
        unless valid_move?(start_column, start_row, end_column, end_row, piece_type)
            puts "#{end_position} is not a valid move for a #{piece_type} at #{start_position}." unless skip_puts
            return false
        end
        if results_in_check?(start_column, start_row, end_column, end_row)
            puts "Invalid move. You cannot put your own king in check." unless skip_puts
            return false
        end
        return true
    end

    def move_piece(start_position, end_position)
        start_column = start_position[0].to_i - 1
        start_row = start_position[1].to_i - 1
        end_column = end_position[0].to_i - 1
        end_row = end_position[1].to_i - 1
        @current_state[end_column][end_row] = @current_state[start_column][start_row]
        @current_state[start_column][start_row] = ""
        if (end_row == 7 || end_row == 0) && @current_state[end_column][end_row].type == "pawn"
            promote(end_column, end_row)
        end
        if check?(@current_state[end_column][end_row].color)
            return 2 if checkmate?(@current_state[end_column][end_row].color)
            return 1
        end
        return 0
    end

    def show_board
        for row in [7,6,5,4,3,2,1,0]
            for column in 0..7
                if @current_state[column][row] == ""
                    print " "
                else
                    print @current_state[column][row].symbol
                end
            end
            print "\n"
        end
    end

    private
    def has_valid_move?(column, row)
        start_position = ""
        start_position += (column+1).to_s
        start_position += (row+1).to_s
        for end_column in 0..7
            for end_row in 0..7
                end_position = ""
                end_position += (end_column+1).to_s
                end_position += (end_row+1).to_s
                return true if is_valid_end?(start_position, end_position, @current_state[column][row].color, @current_state[column][row].type, true)
            end
        end
        return false
    end
    
    def valid_move?(start_column, start_row, end_column, end_row, piece_type, board_state = @current_state)
        case piece_type
        when "king"
            valid_move_king?(start_column, start_row, end_column, end_row)
        when "queen"
            valid_move_rook?(start_column, start_row, end_column, end_row, board_state) || valid_move_bishop?(start_column, start_row, end_column, end_row, board_state)
        when "knight"
            valid_move_knight?(start_column, start_row, end_column, end_row)
        when "bishop"
            valid_move_bishop?(start_column, start_row, end_column, end_row, board_state)
        when "rook"
            valid_move_rook?(start_column, start_row, end_column, end_row, board_state)
        else
            valid_move_pawn?(start_column, start_row, end_column, end_row, board_state)
        end
    end

    def valid_move_king?(start_column, start_row, end_column, end_row)
        column_change, row_change = (start_column - end_column).abs, (start_row - end_row).abs
        return false if column_change > 1 || row_change > 1
        return true
    end

    def valid_move_knight?(start_column, start_row, end_column, end_row)
        return false if start_column == end_column || start_row == end_row
        column_change, row_change = (start_column - end_column).abs, (start_row - end_row).abs
        return false unless column_change + row_change == 3
        return true
    end

    def valid_move_bishop?(start_column, start_row, end_column, end_row, board_state)
        column_change, row_change = (start_column - end_column).abs, (start_row - end_row).abs
        return false unless column_change == row_change
        if start_column > end_column && start_row > end_row
            check_column, check_row = start_column-1, start_row-1
            until check_column == end_column
                return false unless board_state[check_column][check_row] == ""
                check_column -= 1
                check_row -= 1
            end
        elsif start_column > end_column
            check_column, check_row = start_column-1, start_row+1
            until check_column == end_column
                return false unless board_state[check_column][check_row] == ""
                check_column -= 1
                check_row += 1
            end
        elsif start_row > end_row
            check_column, check_row = start_column+1, start_row-1
            until check_column == end_column
                return false unless board_state[check_column][check_row] == ""
                check_column += 1
                check_row -= 1
            end
        else
            check_column, check_row = start_column+1, start_row+1
            until check_column == end_column
                return false unless board_state[check_column][check_row] == ""
                check_column += 1
                check_row += 1
            end
        end
        return true
    end

    def valid_move_rook?(start_column, start_row, end_column, end_row, board_state)
        return false unless start_column == end_column || start_row == end_row
        if start_column == end_column && start_row > end_row
            for row in end_row+1...start_row
                return false unless board_state[start_column][row] == ""
            end
        elsif start_column == end_column
            for row in start_row+1...end_row
                return false unless board_state[start_column][row] == ""
            end
        elsif start_column > end_column
            for column in end_column+1...start_column
                return false unless board_state[column][start_row] == ""
            end
        else
            for column in start_column+1...end_column
                return false unless board_state[column][start_row] == ""
            end
        end
        return true
    end

    def valid_move_pawn?(start_column, start_row, end_column, end_row, board_state)
        return false if start_row == end_row
        column_change, row_change = (start_column - end_column).abs, (start_row - end_row).abs
        return false if column_change + row_change > 2
        return false if column_change == 1 && board_state[end_column][end_row] == ""
        return false if start_column == end_column && board_state[end_column][end_row] != ""
        if board_state[start_column][start_row].color == "white" && start_row == 1
            return false if end_row - start_row < 1
            return false unless board_state[start_column][start_row + 1] == ""
        elsif board_state[start_column][start_row].color == "white"
            return false unless end_row - start_row == 1
        elsif start_row == 6
            return false if start_row - end_row < 1
            return false unless board_state[start_column][start_row - 1] == ""
        else
            return false unless start_row - end_row == 1
        end
        return true
    end

    def results_in_check?(start_column, start_row, end_column, end_row)
        resulting_state = Marshal.load(Marshal.dump(@current_state))
        resulting_state[end_column][end_row] = resulting_state[start_column][start_row]
        resulting_state[start_column][start_row] = ""
        if @current_state[start_column][start_row].color == "white"
            check_color = "black"
        else
            check_color = "white"
        end
        return true if check?(check_color, resulting_state)
        return false
    end

    def check?(color, board_state = @current_state)
        if color == "white"
            king_color = "black"
        else
            king_color = "white"
        end
        for column in 0..7
            for row in 0..7
                if board_state[column][row] != "" && board_state[column][row].color == king_color && board_state[column][row].type == "king"
                    king_column, king_row = column, row
                end
            end
        end
        for column in 0..7
            for row in 0..7
                if board_state[column][row] != "" && board_state[column][row].color == color
                    return true if valid_move?(column, row, king_column, king_row, board_state[column][row].type, board_state)
                end
            end
        end
        return false
    end

    def checkmate?(color)
        if color == "white"
            check_color = "black"
        else
            check_color = "white"
        end
        for column in 0..7
            for row in 0..7
                if @current_state[column][row] != "" && @current_state[column][row].color == check_color
                    return false if has_valid_move?(column, row)
                end
            end
        end
        return true
    end

    def promote(column, row)
        color = @current_state[column][row].color
        valid_choice = false
        until valid_choice
            puts "What kind of piece do you want to promote your pawn to?"
            puts "(q)ueen, (k)night, (b)ishop, or (r)ook?"
            piece_type = gets.chomp.downcase
            next if piece_type.empty?
            if "qkbr".include?(piece_type)
                case piece_type
                when "q"
                    piece_type = "queen"
                when "k"
                    piece_type = "knight"
                when "b"
                    piece_type = "bishop"
                else
                    piece_type = "rook"
                end
                @current_state[column][row] = Piece.new(color, piece_type)
                valid_choice = true
            else
                puts "#{piece_type} is not a valid choice."
            end
        end
    end
end