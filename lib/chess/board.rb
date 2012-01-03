module Chess

  class Board

    def initialize(io = nil)
      if io
        load_from io
      else
        @pieces = [
          Piece::Rook.new(  :white, "a1"),
          Piece::Knight.new(:white, "b1"),
          Piece::Bishop.new(:white, "c1"),
          Piece::Queen.new( :white, "d1"),
          Piece::King.new(  :white, "e1"),
          Piece::Bishop.new(:white, "f1"),
          Piece::Knight.new(:white, "g1"),
          Piece::Rook.new(  :white, "h1"),
          Piece::Rook.new(  :black, "a8"),
          Piece::Knight.new(:black, "b8"),
          Piece::Bishop.new(:black, "c8"),
          Piece::Queen.new( :black, "d8"),
          Piece::King.new(  :black, "e8"),
          Piece::Bishop.new(:black, "f8"),
          Piece::Knight.new(:black, "g8"),
          Piece::Rook.new(  :black, "h8")
        ]
        ("a".."h").each do |column|
          @pieces << Piece::Pawn.new(:white, column + "2")
          @pieces << Piece::Pawn.new(:black, column + "7")
        end
      end
    end

    def apply(move)
      if origin_piece = piece_on(move.origin_square)
        @pieces.delete_if { |piece| piece.square == move.destination_square }
        origin_piece.square = move.destination_square
      end
    end

    def piece_on(square)
      @pieces.find { |piece| piece.square == square }
    end

    def squares_unoccupied_between?(orig_square, dest_square)
      orig_col, orig_row = Board.square_to_col_and_row orig_square
      dest_col, dest_row = Board.square_to_col_and_row dest_square

      row_diff = dest_row - orig_row
      col_diff = dest_col - orig_col

      row_direction = row_diff > 0 ? -1 : 1
      col_direction = col_diff > 0 ? -1 : 1

      if row_diff.zero?

        if col_diff.abs == 1
          true
        else
          previous_dest_square = Board.square_from_col_and_row dest_col + col_direction, dest_row
          piece_on(previous_dest_square).nil? &&
            squares_unoccupied_between?(orig_square, previous_dest_square)
        end

      elsif col_diff.zero?

        if row_diff.abs == 1
          true
        else
          previous_dest_square = Board.square_from_col_and_row dest_col, dest_row + row_direction
          piece_on(previous_dest_square).nil? &&
            squares_unoccupied_between?(orig_square, previous_dest_square)
        end

      else

        if row_diff.abs == 1 && col_diff.abs == 1
          true
        else
          previous_dest_square = Board.square_from_col_and_row dest_col + col_direction, dest_row + row_direction
          piece_on(previous_dest_square).nil? &&
            squares_unoccupied_between?(orig_square, previous_dest_square)
        end

      end

    end

    def is_king_in_check_with?(move)
      move_color = piece_on(move.origin_square).color
      king = @pieces.find { |piece| piece.instance_of?(Chess::Piece::King) && piece.color == move_color }
      other_color_pieces = @pieces.select { |piece| piece.color != move_color }

      destination_piece = piece_on move.destination_square
      apply move
      result = other_color_pieces.any? { |piece| piece.can_move_to? king.square, self }
      apply move.reverse
      @pieces << destination_piece if destination_piece

      result
    end

    private

    def self.square_to_col_and_row(square)
      square =~ /([a-h])(\d)/
        [$1.ord - 97, $2.to_i - 1]
    end

    def self.square_from_col_and_row(col, row)
      (97 + col).chr + (row + 1).to_s
    end

    def load_from(io)
      @pieces = Array.new
      rows    = io.readlines

      rows.reverse.each_with_index do |row, row_index|
        columns = row.split

        columns.each_with_index do |square_content, column_index|
          unless square_content == "--"
            square = Board.square_from_col_and_row column_index, row_index
            @pieces << Piece::Base.create_from_an_notation(square_content, square)
          end
        end
      end
    end

  end

end
