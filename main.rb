require './lib/chess'

name_entered_1 = false
name_entered_2 = false

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

game = Chess.new(player1, player2)
game.play