require './lib/board'
require './lib/player'

class Chess
    def initialize(player1, player2)
        @players = []
        @players.push(Player.new(player1, "white"))
        @players.push(Player.new(player2, "black"))
        @board = Board.new
    end

    def play
        @current_player = @players.first
        @next_player = @players.last
        game_over = false
        until game_over
            piece_to_move = false
            until piece_to_move
                puts
                @board.show_board
                puts
                puts "It's #{@current_player.name}'s turn. Select a piece to move."
                puts "Columns are 1-8 (starting at left), rows are 1-8 (starting at bottom)."
                puts "Enter the column and row of the piece to move (no space), or 'r' to resign:"
                start_position = gets.chomp
                if "rR".include?(start_position)
                    puts "Game over."
                    exit
                end
                piece_to_move = @board.is_valid_start?(start_position, @current_player.piece_color)
            end
            valid_move = false
            until valid_move
                puts
                puts "Enter the column and row of the square to move to:"
                end_position = gets.chomp
                valid_move = true if @board.is_valid_end?(start_position, end_position, @current_player.piece_color, piece_to_move)
            end
            result = @board.move_piece(start_position, end_position)
            if result == 2
                puts "Checkmate! #{@current_player.name} wins."
                puts
                @board.show_board
                game_over = true
            elsif result == 1
                puts "#{@next_player.name}, your king is in check."
                @current_player, @next_player = @next_player, @current_player
            else
                @current_player, @next_player = @next_player, @current_player
            end
        end
    end
end