require_relative '../lib/player'
require_relative '../lib/board'

class Decision_Maker
  attr_reader :response_message
  # possibilities        [0]     [1]      [2]      [3]      [4]    [5]      [6]    [7]
  WIN_POSSIBILITIES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    get_symbol
    get_board
    @moves = {'1'=>'1','2'=>'2','3'=>'3','4'=>'4','5'=>'5','6'=>'6','7'=>'7','8'=>'8','9'=>'9'}
  end

  def get_symbol
    @players = []
    # This creates the selector where the users chooses their symbol
    symbol_list = ['❌','🔵']
    prompt = TTY::Prompt.new
    symb = prompt.enum_select("Player 1! Select your symbol:", symbol_list)
    # This stores the player objects in an instance array
    @players << Player.new(symb)
    @player_turn = @players[0]
    @players << Player.new(symbol_list.select{|x| x!=symb}[0])
    # This returns a response message to be printed
    puts "Player 1 is #{@players[0]} so Player 2 gets #{@players[1]}"
  end

  def get_board
    @board = Board.new
  end

  # once games starts requests 1st move until no more spots are avlbl on board
  def move_sequence
    winner = nil
    until winner || @moves.empty?
      puts @board.the_actual_board
      get_move
      current_player
      system 'clear'
      winner = check_for_winner
      if winner
        @response_message = winner
      end
    end
    system 'clear'
    puts @board.the_actual_board
    @response_message = "It's a draw!" if @moves.empty? && winner == false
  end
  
  #alternates turns between players
  def current_player
    player1 = @players[0]
    player2 = @players[1]
  
    if @player_turn == player1
      @player_turn = player2
    else
      @player_turn = player1
    end
  end

  def get_move
    prompt = TTY::Prompt.new
    @move = prompt.enum_select("Player #{@player_turn.symbol} make a move:", @moves)
    position_remover(@move)
    @board.print_move(@move, @player_turn.symbol)
    @response_message = "Awesome! You have moved to space #{@move}!"
  end

  # removes options form the prompt as they become selected
  def position_remover(position)
    @moves.delete(position)
  end
  #checks for win
  def check_for_winner
    answer = false
    WIN_POSSIBILITIES.each do |possibilities|
      case @board.board.values_at(*possibilities)
      when %w(🔵 🔵 🔵)
        answer = 'Player 🔵 wins'
      when %w(❌ ❌ ❌)
        answer = 'Player ❌ wins'
      end
    end
    answer
  end

end
