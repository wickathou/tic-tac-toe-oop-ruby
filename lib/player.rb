class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end

  def to_s
    @symbol
  end
end
