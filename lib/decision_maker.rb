require_relative '../lib/player'
require_relative '../lib/board'

class DecisionMaker
  attr_reader :response_message, :winner, :moves
  # possibilities        [0]     [1]      [2]      [3]      [4]    [5]      [6]    [7]
  WIN_POSSIBILITIES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def initialize(symb1, symb2)
    @winner = nil
    symbol_get(symb1, symb2)
    board_get
    @moves = { '1' => '1', '2' => '2', '3' => '3', '4' => '4',
               '5' => '5', '6' => '6', '7' => '7', '8' => '8', '9' => '9' }
  end

  def symbol_get(symb1, symb2)
    @players = []
    # This stores the player objects in an instance array
    @players << Player.new(symb1)
    @player_turn = @players[0]
    @players << Player.new(symb2)
    # This returns a response message to be printed
    @response_message = "Player 1 is #{@players[0]} so Player 2 gets #{@players[1]}"
  end

  # once games starts requests 1st move until no more spots are avlbl on board
  def move_sequence
    current_player
    @winner = check_for_winner(@board.board) if @moves.size <= 5
    @response_message = if @winner
                          @winner
                        elsif @moves.empty? && @winner == false
                          "It's a draw!"
                        else
                          "Awesome! You have moved to space #{@move}!"
                        end
  end

  # alternates turns between players
  def current_player
    alternator = @player_turn
    @player_turn = alternator == @players[0] ? @players[1] : @players[0]
  end

  def move_get( test_move = nil )
    if test_move
      @move = test_move
    else
      prompt = TTY::Prompt.new
      @move = prompt.enum_select("Player #{@player_turn.symbol} make a move:", @moves)
    end
    position_remover(@move)
    @board.print_move(@move, @player_turn.symbol)
  end

  # removes options form the prompt as they become selected
  def position_remover(position)
    @moves.delete(position)
  end

  # checks for win
  def check_for_winner(board)
    answer = false
    WIN_POSSIBILITIES.each do |possibilities|
      case board.values_at(*possibilities)
      when %w[🔵 🔵 🔵]
        answer = 'Player 🔵 wins'
      when %w[❌ ❌ ❌]
        answer = 'Player ❌ wins'
      end
    end
    answer
  end
  
  def print_board
    system 'clear'
    @response_message = @board.the_actual_board
  end
  
  private
  
  def board_get
    @board = Board.new
  end
end
