module Chess

  module Piece

    class Rook < Chess::Piece::Base

      def can_move_to?(destination_square, board)
        move = Chess::Move.new square + " " + destination_square

        (board.piece_on(destination_square).nil? || board.piece_on(destination_square).color != color) &&
          board.squares_unoccupied_between?(move.origin_square, move.destination_square) &&
          ( (!move.rows_nb_changed.zero? && move.columns_nb_changed.zero?) || (move.rows_nb_changed.zero? && !move.columns_nb_changed.zero? ) ) &&
          !board.is_king_in_check_with?(move)
      end

    end

  end

end
