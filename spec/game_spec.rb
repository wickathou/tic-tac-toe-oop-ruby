require_relative '../lib/decision_maker'
require_relative '../lib/board'
 
 describe DecisionMaker do
  let(:x){"❌"}
  let(:o){"🔵"}
  let(:logic){DecisionMaker.new(x, o)}
  let(:board){Board.new}
  describe "#check_for_winner" do
    let(:winx){"Player #{x} wins"}
    let(:wino){"Player #{o} wins"}
    it "wins with row top" do
      (0..2).each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with row middle" do
      (3..5).each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with row bottom" do
      (6..8).each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with column top" do
      [0,3,6].each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with column middle" do
      [1,4,7].each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with column bottom" do
      [2,5,8].each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with diagonal top left to bottom right" do
      [0,4,8].each{ |i| board.board[i] = x}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
    it "wins with diagonal top right to bottom left" do
      [2,4,6].each{ |i| board.board[i] = "❌"}
      expect(logic.check_for_winner(board.board)).to eq(winx).or eq(wino)
    end
  end
  
  describe "#symbol_get" do
    it "defines the symbol of each player" do
      expect(logic.symbol_get(x, o)).to eq("Player 1 is #{x} so Player 2 gets #{o}").or eq("Player 1 is #{o} so Player 2 gets #{x}")
    end
  end
  
  describe "#current_player" do
    it "alternates player turns" do
      expect(logic.current_player).not_to eq(logic.current_player)
    end
  end

  describe "#position_remover" do
    it "checks that the options from the prompt are being removed as they are selected" do
      (1..9).each { |i| logic.position_remover(i.to_s) }
      expect(logic.moves).to eq({})
    end
  end

  describe "#move_sequence" do
    it "checks for a draw when full board and no winner" do
      (1..9).each do |i|
        logic.position_remover(i.to_s)
      end
      expect(logic.move_sequence).to eq("It's a draw!")
    end

    it "checks that player moves if no win or draw" do
      (1..8).each do |i|
        logic.position_remover(i.to_s)
      end
      expect(logic.move_sequence).to eq("Awesome! You have moved to space #{@move}!")
    end
  end

end