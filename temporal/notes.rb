# 1. Welcome Players to Game
# 2. Ask Players to Select Who they wanna be
# 3. Validate User inputs
# 4. Print Welcome with New Players (Selected and validated)
# 5. Issue Game instructions (just puts)
# 6. Ask Player to Select any available position form (1-9) on the board
# 7. Verify user Input
  #7.2 if user input valid (the selected position is avlbl)
    # 7.2.1 Verify if there's a win yet or full board if not
    # *** Print board with new selected position and go back to 6
    # elsif its winner and loser announce winner and loser and End Game.
    # else announce full board and end game.
  #7.3 if user input invalid return Error Message


# IN DEVELOPMENT
#!/usr/bin/env ruby

require 'tty-prompt'
# creating the instance of the game
#   loop ends if win/loss or 9 movements done
#     user inputs alternating between the 2 users
#     validate if win/draw
#     print board if no win
#     win/loss announce if win/draw
# end

# GAME CLASS
  # MAGA
class Game
  def initialize
    greeting
    start_decision_maker
    create_board
    user_input
  end

  def greeting
    puts "Hello! Welcome to Tic-Tac-Toe!"
    puts "Please Select, Would you like to be Player ❌ or Player 🔵?"
    # (0..1).each{|player| player = Player.new(@valiadator.get_symbol)}
    # @board = Board.new
  end

  def start_decision_maker
    @decision_maker = Decision_Maker.new
    puts @decision_maker.response_message
  end

  def user_input
    @decision_maker.get_move
    puts @decision_maker.response_message
  end

  def create_board
    puts 'Here is your starting Board. As you can see, it is empty'
    puts 'Select a position between 1-9 As long as it is available'
    @the_board = Board.new
    puts @the_board.the_actual_board
    #creates the new something of the board
  end
  
  def print_move
    #receive validated input
    #print new board with validated input
  end

  def win_lost_announce
    # Congratulations! yOu've won!
    # Boohoo you've lost player bla
  end
end

class Player
  def initialize(symbol)
    @symbol = symbol
  end

  def to_s
    @symbol
  end
end

  # gets.chomp of Player inputs
  # receives user input
  # returns user input to Decision_Maker class
  # receive from valiator class
  # return to Game Class
  # Player A is always ❌
  # Player B is always 🔵

class Decision_Maker
  attr_accessor :response_message
  def initialize
    get_symbol
    get_board
  end

  def get_symbol
    @players = []
    # This creates the selector where the users chooses their symbol
    symbol_list = ['❌','🔵']
    prompt = TTY::Prompt.new
    symb = prompt.enum_select("Player 1! Select your symbol?", symbol_list)
    # This stores the player objects in an instance array
    @players << Player.new(symb)
    @players << Player.new(symbol_list.select{|x| x!=symb}[0])
    # This returns a response message to be printed
    @response_message = "Player 1 chose #{@players[0]}, player 2 get #{@players[1]}"
  end

  def get_board
    @board = Board.new
  end

  def get_move
    # This creates the selector where the users chooses their symbol
    @moves = (1..9).to_a
    prompt = TTY::Prompt.new
    move = prompt.enum_select("make a move?", @moves)
    # This stores the player objects in an instance array
    # @players << Player.new(symb)
    # @players << Player.new(symbol_list.select{|x| x!=symb}[0])
    # This returns a response message to be printed
    @response_message = "Awesome! You have coronavirus, don't take vaccines, drink fabuloso+cloralex #{move}"
  end
end
  # VALIDATION PART 1
  # gets all inputs from Game Class and Players Class
  # Validates
  # if player_input == true return value to corresponding class
  # else return "Sorry, invalid input. Try again"

  # VALIDATION PART 2
  # gets position input from Board Class
  # Validates
  # if postion_input == avlbl position return to corresponding Class
  # else return "Sorry, that spot is already taken, please select another # from 1-9"

  # VALIDATION PART 3
  # Receive board_status (Available/Unavailable spots)
  # Check if | or \ or --- positions are filled return WIN
    # Check if WIN is by X or O return WINNER & LOSER
  # else continue game

class Board
  def initialize
    the_actual_board
  end
  def the_actual_board
    board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    board_arra = [" #{board[0]} | #{board[1]} | #{board[2]} ", '-----------',
     " #{board[3]} | #{board[4]} | #{board[5]} ", '-----------',
     " #{board[6]} | #{board[7]} | #{board[8]} "]
  end
end

Game.new
