module Chess

  module Piece

    class Queen < Chess::Piece::Base

      def can_move_to?(destination_square, board)
        Rook.new(color, square).can_move_to?(destination_square, board) || Bishop.new(color, square).can_move_to?(destination_square, board)
      end

    end

  end

end
