module Chess

  class Move < Struct.new(:algebric_notation)

    def columns_nb_changed
      (destination_column.ord - origin_column.ord).abs
    end

    def destination_column
      destination_square[/\w/]
    end

    def destination_row
      destination_square[/\d/]
    end

    def destination_square
      algebric_notation[/\S+$/]
    end

    def origin_column
      origin_square[/\w/]
    end

    def origin_row
      origin_square[/\d/]
    end

    def origin_square
      algebric_notation[/^\S+/]
    end

    def reverse
      Move.new destination_square + " " + origin_square
    end

    def rows_nb_changed
      destination_row.to_i - origin_row.to_i
    end

  end

end
