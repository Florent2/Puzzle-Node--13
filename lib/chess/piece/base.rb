module Chess

  module Piece

    class Base < Struct.new(:color, :square)

      def self.create_from_an_notation(an_piece, square) # 'an' stands for Algebric Notation
        an_piece =~ /([wb])([PRNBQK])/
          
        color = case $1
                when "w" 
                  :white
                when "b"
                  :black 
                end

        case $2
        when "P" 
          Pawn.new color, square
        when "R"
          Rook.new color, square
        when "N"
          Knight.new color, square
        when "B"
          Bishop.new color, square
        when "Q"
          Queen.new color, square
        when "K"
          King.new color, square
        end
      end

    end

  end
  
end

