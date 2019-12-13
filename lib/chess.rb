require './lib/board'
require './lib/player'
require 'yaml'

class Chess
    def initialize(player1, player2, load_game = false)
        unless load_game
            @players = []
            @players.push(Player.new(player1, "white"))
            @players.push(Player.new(player2, "black"))
            @board = Board.new
        end
        if load_game
            load
        end
    end

    def load
        save_data = YAML.load(File.read("chess.yml"))
        @board = save_data[:board]
        @players = save_data[:players]
        @current_player = save_data[:current]
        @next_player = save_data[:next]
        @loaded_game = true
    end

    def play
        @current_player = @players.first unless @loaded_game
        @next_player = @players.last unless @loaded_game
        game_over = false
        until game_over
            piece_to_move = false
            until piece_to_move
                castling = false
                puts
                @board.show_board
                puts
                puts "It's #{@current_player.name}'s turn. Select a piece to move."
                puts "Columns are 1-8 (starting at left), rows are 1-8 (starting at bottom)."
                puts "Enter column & row of piece to move (with no space in between)."
                puts "Or, enter 'c' to castle, 'r' to resign, or 's' to save:"
                start_position = gets.chomp
                next if start_position.empty?
                if "rR".include?(start_position)
                    puts "Game over."
                    exit
                end
                castling = true if "cC".include?(start_position)
                next puts "You cannot castle." if castling unless @board.can_player_castle?(@current_player.piece_color, "q") || @board.can_player_castle?(@current_player.piece_color, "k")
                break if castling
                if "sS".include?(start_position)
                    save
                    puts "Game saved."
                    exit
                end
                piece_to_move = @board.is_valid_start?(start_position, @current_player.piece_color)
            end
            valid_move = false
            until valid_move
                break if castling
                puts
                puts "Enter the column and row of the square to move to:"
                end_position = gets.chomp
                next if end_position.empty?
                valid_move = true if @board.is_valid_end?(start_position, end_position, @current_player.piece_color, piece_to_move)
            end
            result = @board.move_piece(start_position, end_position) unless castling
            if castling
                until valid_move
                    result = 0
                    puts
                    puts "Do you want to castle (q)ueenside, (k)ingside, or (c)ancel?"
                    side = gets.chomp.downcase
                    next if side.empty?
                    next unless "ckq".include?(side)
                    result = false if "c".include?(side)
                    break unless result
                    result = false if side == "q" unless @board.can_player_castle?(@current_player.piece_color, side)
                    puts "You cannot castle queenside." if side == "q" unless @board.can_player_castle?(@current_player.piece_color, side)
                    result = false if side == "k" unless @board.can_player_castle?(@current_player.piece_color, side)
                    puts "You cannot castle kingside." if side == "k" unless @board.can_player_castle?(@current_player.piece_color, side)
                    next unless result
                    result = @board.move_pieces_castling(@current_player.piece_color, side)
                    valid_move = true
                end
            end
            next unless result
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

    private
    def save
        save_data = { board: @board,
                    players: @players,
                    current: @current_player,
                    next: @next_player }
        save_file = File.open("chess.yml","w") { |file| file.write(save_data.to_yaml) }
    end
end