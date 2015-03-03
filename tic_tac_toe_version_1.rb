# Tic Tac Toe
# By Ricardo Rojo
# 02/02/2015
# ============

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

def computers_play(board)
  if get_emptyspaces(board).count > 0
    position = get_emptyspaces(board).sample
    board[position] = "O"
  end
end

def valid_position?(position, board)
  if position >= 1 && position <= 9 && board[position] == " "
    return true
  else
    return false
  end
end

def winner?(board, winning_lines, position_marker)
  winning_lines.each do |winning_play|
    if board[winning_play[0]] == position_marker && board[winning_play[1]] == position_marker && board[winning_play[2]] == position_marker
      return true
    end
  end
  return false
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
  computers_play(board)
  if winner?(board, winning_lines, COMPUTER_POSITION_MARKER)
    paint_board(board)
    puts "Computer Wins!!"
    exit
  end
  paint_board(board)
  number_of_plays += 2
end while number_of_plays < 9

puts "It´s a draw"
