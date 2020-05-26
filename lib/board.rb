class Board
  attr_reader :board

  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    the_actual_board
  end

  def the_actual_board
    [
      " #{@board[0]} | #{@board[1]} | #{@board[2]} ",
      '-----------',
      " #{@board[3]} | #{@board[4]} | #{@board[5]} ",
      '-----------',
      " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    ]
  end

  def print_move(move, player_turn)
    @board[move.to_i - 1] = player_turn
  end
end
