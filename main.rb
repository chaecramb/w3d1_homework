require 'pry-byebug'

require_relative 'game'
require_relative 'move'

puts `clear`
puts "Playing TTT..."

def expect(thing, other_thing)
  raise "#{thing} did not equal #{other_thing}" unless thing == other_thing
end

def print_board(g)
  puts(g.board.each_with_index.each_slice(3).map do |row|
    row.map do |e, i| 
      e || "#{i}" 
    end.join(' | ')
  end.join("\n---------\n"))
end

g = Game.new

expect g.class.name, "Game" # this should be true
expect g.moves, [] # this should be true

g.player1 = "Michael"
g.player2 = "Neil"

expect g.player1, "Michael"
expect g.player2, "Neil"

g.make_move "Michael", 4

expect g.moves.last.class.name, "Move"

expect g.moves.last.player, "Michael"
expect g.moves.last.square, 4
expect g.moves.last.symbol, "X"

g.make_move "Neil", 7

expect g.moves.last.player, "Neil"
expect g.moves.last.square, 7
expect g.moves.last.symbol, "O"

expect g.finished?, false

g.make_move "Michael", 0
g.make_move "Neil", 1
g.make_move "Michael", 8


expect g.finished?, true

expect g.result, "Michael won!"




g = Game.new

puts "What is player 1's name?"
g.player1 = gets.chomp

puts "What is player 2's name?"
g.player2 = gets.chomp

until g.finished?
  puts `clear`
  print_board(g)
  puts
  puts "Where's #{g.whose_turn}'s move?"
  g.make_move g.whose_turn, gets.to_i
end

puts `clear`
puts print_board(g)
puts g.result



binding.pry;''





