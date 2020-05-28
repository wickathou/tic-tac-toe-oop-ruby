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
  
end