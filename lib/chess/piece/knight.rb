module Chess

  module Piece

    class Knight < Chess::Piece::Base

      def can_move_to?(destination_square, board)
        move = Chess::Move.new square + " " + destination_square

        (board.piece_on(destination_square).nil? || board.piece_on(destination_square).color != color) &&
          ( (move.rows_nb_changed.abs == 1 && move.columns_nb_changed.abs == 2) || (move.rows_nb_changed.abs == 2 && move.columns_nb_changed.abs == 1) ) &&
          !board.is_king_in_check_with?(move)
      end

    end

  end

end
