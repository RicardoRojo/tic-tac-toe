# Tic Tac Toe
# By Ricardo Rojo
# 02/02/2015
# ============
require 'pry'
# CONSTANTS and variables
PLAYER_POSITION_MARKER = "X"
COMPUTER_POSITION_MARKER = "O"
board = {}
winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
correct_choice = false
number_of_plays = 0
empty_spaces = []

#Methods
def initialize_board(board, empty_spaces)
  (1..9).each {|index| board[index] = ' '}
  (1..9).each {|index| empty_spaces << index}
end

def paint_board(board)
  system('clear')
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "---+---+---"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "---+---+---"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
end

def get_emptyspaces(board)
  board.select {|key,value| value == " "}.keys
end

def players_play(board)
  begin
    puts "Choose a position (1-9)"
    position = gets.chomp
    correct_position = valid_position?(position.to_i, board)
  end while !correct_position
  board[position.to_i] = "X"
end

def computers_play(board, winning_lines)
  if get_emptyspaces(board).count > 0
    position = two_in_a_row(board, winning_lines)
    if !position
      position = get_emptyspaces(board).sample
    end
    board[position] = "O"
  end
end

def valid_position?(position, board)
  position >= 1 && position <= 9 && board[position] == " "
end

def two_in_a_row(board, winning_lines)
  winning_lines.each do |line|
    working_hash = {}
    line.each do |position_marker|
      working_hash[position_marker] = board[position_marker]
    end
    if working_hash.values.count("X") == 2 && working_hash.values.count("O") == 0
      return working_hash.select {|key,position| position == " "}.keys.first
    end
  end
  return false
end

def winner?(board, winning_lines, position_marker)
  winning_lines.each do |winning_play|
    if winning_combination?(board,winning_play,position_marker)
      return true
    end
  end
  return false
end

def winning_combination?(board, winnig_play, position_marker)
  working_array = []
  winnig_play.each {|position| working_array << board[position]}
  working_array.select {|position| position == position_marker}.count == 3
end

# Execution of program
initialize_board(board, empty_spaces)
paint_board(board)
begin
  players_play(board)
  if winner?(board, winning_lines, PLAYER_POSITION_MARKER)
    paint_board(board)
    puts "You Win!!. Good Job"
    exit
  end
  computers_play(board, winning_lines)
  if winner?(board, winning_lines, COMPUTER_POSITION_MARKER)
    paint_board(board)
    puts "Computer Wins!!"
    exit
  end
  paint_board(board)
  number_of_plays += 2
end while number_of_plays < 9

puts "It´s a draw"
