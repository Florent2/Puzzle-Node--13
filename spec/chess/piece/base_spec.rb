require "minitest/autorun"
require_relative "../../../lib/chess"

describe Chess::Piece::Base do

  describe ".create_from_an_notation(an_piece)" do

    it "creates a white piece if argument starts with 'w'" do
      piece = Chess::Piece::Base.create_from_an_notation("wP", "a1")

      piece.color.must_equal :white
    end

    it "creates a black piece if argument starts with 'b'" do
      piece = Chess::Piece::Base.create_from_an_notation("bP", "a1")

      piece.color.must_equal :black
    end

    it "creates a Pawn instance if argument finishes with 'P'" do
      piece = Chess::Piece::Base.create_from_an_notation("bP", "a1")

      piece.must_be_instance_of Chess::Piece::Pawn
    end

    it "creates a Bishop instance if argument finishes with 'B'" do
      piece = Chess::Piece::Base.create_from_an_notation("bB", "a1")

      piece.must_be_instance_of Chess::Piece::Bishop
    end

    it "creates a Rook instance if argument finishes with 'R'" do
      piece = Chess::Piece::Base.create_from_an_notation("bR", "a1")

      piece.must_be_instance_of Chess::Piece::Rook
    end

    it "creates a Knight instance if argument finishes with 'N'" do
      piece = Chess::Piece::Base.create_from_an_notation("bN", "a1")

      piece.must_be_instance_of Chess::Piece::Knight
    end

    it "creates a Queen instance if argument finishes with 'Q'" do
      piece = Chess::Piece::Base.create_from_an_notation("bQ", "a1")

      piece.must_be_instance_of Chess::Piece::Queen
    end

    it "creates a King instance if argument finishes with 'K'" do
      piece = Chess::Piece::Base.create_from_an_notation("bK", "a1")

      piece.must_be_instance_of Chess::Piece::King
    end

  end

end

