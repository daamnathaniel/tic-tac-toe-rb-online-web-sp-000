


WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
  [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, player)
    board[index] = player
end

def position_taken?(board, position)
	!(board[position] == " " || board[position] == "")
end

def valid_move?(board, position)
    !position_taken?(board, position) && position.between?(0,8)
end

def turn_count(board)
	
	counter = 0
	board.each do |token|
		if token == "O" || token == "X"
			counter += 1
		end
	end
	counter
end

def current_player(board)
	turn_count(board).even? ? "X" : "O"
end


def turn(board)
	puts 'Please enter 1-9:'
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
    	turn(board)
    end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) 
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end


def play(board)
    turn(board) until over?(board)
	if won?(board)
		puts "Congratulations #{winner(board)}!"
	elsif draw?(board)
		puts "Cat's Game!"
	end

end
