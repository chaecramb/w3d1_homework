class Game
  attr_accessor :player1, :player2
  attr_reader :moves

  WINNING_LINES = [ [0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8] ]

  def initialize
    @moves = []
  end

  def valid_name?
    !(player1 == player2)
  end

  def whose_turn
    return player1 if moves.empty?
    moves.last.player == player1 ? player2 : player1
  end

  def correct_player?(player)
    player == whose_turn
  end

  def on_board?(square)
    square <= board.size && square >= 0
  end

  def square_taken?(square)
    !!board[square]
  end

  def valid_move?(player, square)
     !square_taken?(square) && !finished? && correct_player?(player) &&on_board?(square)
    # make sure players move, make sure game not finished
  end

  def make_move(player, square)
    if valid_move?(player, square)
      @moves << Move.new(player, square, symbol_for_player(player) )
    else
      puts "Invalid move. Press enter to continue."
      gets
    end
  end

  def finished?
    winning_game? || drawn_game?  
  end

  def board
    board = empty_board

    moves.each do |move|
      board[move.square] = move.symbol
    end

    board
    # alt:
    # empty_board.tap do |board|
    #   moves.each do|move|
    #     board[move.square] = move.symbol
    #   end
    # end
  end

  def empty_board
    Array.new(9,nil)
  end

  def result
    case 
    when winning_game?
      "#{moves.last.player} won!"
    when drawn_game?
      "It's a draw!"
    else
      "Game's still in progress."
    end
  end

  private

  def symbol_for_player(player)
    case player
    when player1 
      'X'
    when player2
      'O'
    else
      raise "OI! That's not one of my players"
    end
  end

  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
      %w(XXX OOO).include?(winning_line.map { |e| board[e] }.join)
    end
  end

  def drawn_game?
    moves.size == 9
  end

end
