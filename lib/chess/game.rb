module Chess

  class Game

    attr_reader :board

    def initialize(board = Board.new)
      @board = board
    end

    def is_move_legal?(move)
      piece = @board.piece_on move.origin_square

      !piece.nil? && 
        move.origin_square != move.destination_square &&
        piece.can_move_to?(move.destination_square, @board)
    end

  end

end
