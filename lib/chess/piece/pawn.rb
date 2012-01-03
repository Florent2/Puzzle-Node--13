module Chess

  module Piece

    class Pawn < Chess::Piece::Base

      def can_move_to?(destination_square, board)
        move = Chess::Move.new square + " " + destination_square

        (
          move.rows_nb_changed == 1 * move_direction && 
          move.columns_nb_changed.zero? && 
          board.piece_on(destination_square).nil? &&
          !board.is_king_in_check_with?(move)
        ) ||
          (
            move.rows_nb_changed == 2 * move_direction && 
            move.columns_nb_changed.zero? && 
            board.piece_on(destination_square).nil? &&
            move.origin_row == start_row &&
            board.piece_on("#{move.origin_column}#{move.origin_row.to_i + move_direction}").nil? && # check if first front square is unoccupied
            !board.is_king_in_check_with?(move)
        ) ||
          (
            move.rows_nb_changed == 1 * move_direction && 
            move.columns_nb_changed == 1 && 
            !board.piece_on(destination_square).nil? &&
            board.piece_on(destination_square).color != color &&
            !board.is_king_in_check_with?(move)
        )
      end

      private

      def move_direction
        case color
        when :white
          1
        when :black
          -1
        end
      end

      def start_row
        case color
        when :white
          "2"
        when :black
          "7"
        end
      end

    end

  end

end
