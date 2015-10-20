class Move
  attr_reader :player, :square, :symbol

  def initialize(player, square, symbol)
    @player = player
    @square = square
    @symbol = symbol
  end
end
