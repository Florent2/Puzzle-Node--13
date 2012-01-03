#!/usr/bin/env ruby

require_relative "./lib/chess"

abort "Usage: ./chess_move_evaluator.rb board_file_name moves_file_name" unless ARGV.size == 2

board_file = File.new ARGV[0]
moves_file = File.new ARGV[1]

board = Chess::Board.new board_file
game  = Chess::Game.new board

moves_file.readlines.each_with_index do |an_move, index|
  move = Chess::Move.new an_move

  if game.is_move_legal?(move)
    puts "LEGAL"
  else
    puts "ILLEGAL"
  end
end
