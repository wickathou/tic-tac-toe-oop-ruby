require_relative '../lib/game'
require_relative '../lib/decision_maker'
require_relative '../lib/board'

describe Game do
  let(:testing) { Game.new('testing') }
  let(:alt) { Game.new('alt') }
  let(:altloser) { Game.new('altloser') }
  let(:loser) { Game.new('loser') }
  let(:draw) { Game.new('draw') }
  let(:altdraw) { Game.new('altdraw') }
  describe '#Game.new' do
    it 'Test the complete game, player x wins' do
      expect(testing.test_result).to eq('Player ❌ wins')
    end

    it 'Test the complete game, player o wins' do
      expect(alt.test_result).to eq('Player 🔵 wins')
    end

    it 'Test the complete game, player x loses' do
      expect(altloser.test_result).to eq('Player ❌ looses')
    end

    it 'Test the complete game, player o loses' do
      expect(loser.test_result).to eq('Player 🔵 looses')
    end

    it 'Test the complete game, game is a draw' do
      expect(draw.test_result).to eq("It's a draw!")
    end

    it 'Test the complete game, game is a draw but with swapped player symbols' do
      expect(altdraw.test_result).to eq("It's a draw!")
    end
  end
end

describe DecisionMaker do
  let(:x) { '❌' }
  let(:o) { '🔵' }
  let(:logic) { DecisionMaker.new(x, o) }
  let(:board) { Board.new }
  describe '#check_for_winner' do
    let(:winx) { "Player #{x} wins" }
    let(:wino) { "Player #{o} wins" }
    it 'wins with row top' do
      (0..2).each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with row middle' do
      (3..5).each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with row bottom' do
      (6..8).each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with column top' do
      [0, 3, 6].each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with column middle' do
      [1, 4, 7].each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with column bottom' do
      [2, 5, 8].each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with diagonal top left to bottom right' do
      [0, 4, 8].each { |i| board.board[i] = x }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it 'wins with diagonal top right to bottom left' do
      [2, 4, 6].each { |i| board.board[i] = '❌' }
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
  end

  describe '#symbol_get' do
    it 'defines the symbol of each player' do
      expect(logic.symbol_get(x, o))
        .to eq("Player 1 is #{x} so Player 2 gets #{o}").or eq("Player 1 is #{o} so Player 2 gets #{x}")
    end
  end

  describe '#current_player' do
    it 'alternates player turns' do
      expect(logic.current_player).not_to eq(logic.current_player)
    end
  end

  describe '#position_remover' do
    it 'checks that the options from the prompt are being removed as they are selected' do
      (1..9).each { |i| logic.position_remover(i.to_s) }
      expect(logic.moves).to eq({})
    end
  end

  describe '#move_sequence' do
    it 'checks for a draw when full board and no winner' do
      (1..9).each do |i|
        logic.position_remover(i.to_s)
      end
      expect(logic.move_sequence).to eq("It's a draw!")
    end

    it 'checks that player moves if no win or draw' do
      (1..8).each do |i|
        logic.position_remover(i.to_s)
      end
      expect(logic.move_sequence).to eq("Awesome! You have moved to space #{@move}!")
    end
  end

  describe '#print_board' do
    it 'Returns an instance variable assignment with the board to print' do
      expect(logic.print_board).to eq(board.the_actual_board)
    end
  end
end

describe Player do
  let(:player) { Player.new('x') }
  describe '#to_s' do
    it 'Prints the player symbol directly when transforming the instance to string' do
      expect(player.to_s).to eq('x')
    end
  end
end

describe Board do
  let(:board) { Board.new }
  describe '#the_actual_board' do
    it 'Returns the board shape as an array for printing' do
      expect(board.the_actual_board).to eq([
                                             ' 1 | 2 | 3 ',
                                             '-----------',
                                             ' 4 | 5 | 6 ',
                                             '-----------',
                                             ' 7 | 8 | 9 '
                                           ])
    end
  end

  describe '#print_move' do
    it 'Registers the position that a player chose, by taking the number-1, & registering the position on an array' do
      expect(board.print_move(1, 'x')).to eq(board.board[0])
    end
  end
end
