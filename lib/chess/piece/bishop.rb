module Chess

  module Piece

    class Bishop < Chess::Piece::Base

      def can_move_to?(destination_square, board)
        move = Chess::Move.new square + " " + destination_square

        (board.piece_on(destination_square).nil? || board.piece_on(destination_square).color != color) &&
          board.squares_unoccupied_between?(square, destination_square) &&
          move.rows_nb_changed.abs == move.columns_nb_changed.abs &&
          !board.is_king_in_check_with?(move)
      end

    end

  end

end
