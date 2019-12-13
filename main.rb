require './lib/chess'

valid_input = false
load_game = false

if File.exist?("chess.yml")
    until valid_input
        puts "(S)tart a new game or (l)oad a saved game?"
        choice = gets.chomp
        next if choice.empty?
        next unless "sSlL".include?(choice)
        valid_input = true
        load_game = true if "lL".include?(choice)
        puts
    end
end

name_entered_1 = false
name_entered_2 = false

unless load_game
    until name_entered_1
        puts "Player 1, what's your name?"
        player1 = gets.chomp
        next if player1.empty?
        name_entered_1 = true
        puts
    end
    until name_entered_2
        puts "Player 2, what's your name?"
        player2 = gets.chomp
        next if player2.empty?
        name_entered_2 = true
    end
end

game = Chess.new(player1, player2) unless load_game
game = Chess.new("player1", "player2", true) if load_game
game.play