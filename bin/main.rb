#!/usr/bin/env ruby

require 'tty-prompt'

require_relative '../lib/decision_maker'

# GAME CLASS
class Game
  attr_reader :test_result
  
  def initialize( testing = nil )
    greeting
    if testing
      testing_mode(testing)
    else
      new_game
    end
  end

  def new_game
    start_decision_maker
    user_input
    restart
  end

  private

  def greeting
    puts 'Tic Tac Toe: two rivals, two symbols, only one chance to win...'
  end

  def start_decision_maker( testing = nil)
    puts 'Please Select, Would you like to be Player ❌ or Player 🔵?'
    symbol_list = testing_symbol(testing)
    if testing
      symb1 = symbol_list[0]
      symb2 = symbol_list[1]
    else      
      prompt = TTY::Prompt.new
      symb1 = prompt.enum_select('Player 1! Select your symbol:', symbol_list)
      symb2 = symbol_list.reject { |x| x == symb1 }[0]
    end
    @decision_maker = DecisionMaker.new(symb1, symb2)
    puts @decision_maker.response_message
    board_printer
  end
  
  def testing_symbol(mode = nil)
    case mode 
    when 'alt', 'altdraw', 'altloser'
      ['🔵', '❌']
    else
      ['❌', '🔵']
    end
  end

  def user_input( testing = nil )
    i = 0
    ar = testing_movement(testing)
    until @decision_maker.winner || @decision_maker.moves.empty?
      if testing
        new_move(ar[i].to_s)
        i += 1
      else
        new_move
      end
      board_printer
      next_player
    end
  end

  def new_move( test_move = nil )
    @decision_maker.move_get(test_move)
    puts @decision_maker.response_message
  end

  def next_player
    @decision_maker.move_sequence
    puts @decision_maker.response_message
  end

  def board_printer
    @decision_maker.print_board
    puts @decision_maker.response_message
  end

  def restart( testing = nil)
    if testing
      @decision_maker.response_message
    else
      prompt = TTY::Prompt.new
      new_game if prompt.yes?('Play again?') do |ans|
        ans.default false
      end
    end
  end

  def testing_mode(testing)
    start_decision_maker(testing)
    user_input(testing)
    restart(testing)
    if testing == 'loser' || testing == 'altloser'
      @test_result = game_end_check(testing)
    else
      @test_result = @decision_maker.response_message
    end
  end
  
  def testing_movement(goal)
    case goal
    when 'draw', 'altdraw'
      [1, 3, 2, 4, 6, 5, 7, 9, 8]
    else
      [1,2,3,4,5,6,7,8,9]
    end
  end
  
  def game_end_check(check)
    if check == 'loser' || check == 'altloser'
      case @decision_maker.response_message
      when 'Player 🔵 wins'
        'Player ❌ looses'
      when 'Player ❌ wins'
        'Player 🔵 looses'
      end
    end
  end
end

# Game.new