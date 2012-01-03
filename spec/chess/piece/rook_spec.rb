require "minitest/autorun"
require_relative "../../../lib/chess"

describe Chess::Piece::Rook do

  before do
    @board = Chess::Board.new
    @board.apply Chess::Move.new("a1 d4")
    @rook = @board.piece_on "d4"
  end

  describe "can_move_to?(square, board)" do

    describe "move along a row" do

      it "can move along empty squares" do
        @rook.can_move_to?("h4", @board).must_equal true
      end

      it "can not move to a square occupied by a piece of the same color" do
        @board.apply Chess::Move.new("h2 h4")

        @rook.can_move_to?("h4", @board).must_equal false
      end

      it "can move to a square occupied by a piece of the other color" do
        @board.apply Chess::Move.new("h7 h4")

        @rook.can_move_to?("h4", @board).must_equal true
      end

      it "can not move to a square if intermediate square is occupied" do
        @board.apply Chess::Move.new("g2 g4")

        @rook.can_move_to?("h4", @board).must_equal false
      end

    end

    describe "move along a column" do

      it "can move along empty squares" do
        @rook.can_move_to?("d6", @board).must_equal true
      end

      it "can not move to a square occupied by a piece of the same color" do
        @rook.can_move_to?("d2", @board).must_equal false
      end

      it "can move to a square occupied by a piece of the other color" do
        @rook.can_move_to?("d7", @board).must_equal true
      end

      it "can not move to a square if intermediate square is occupied" do
        @board.apply Chess::Move.new("a8 d6")

        @rook.can_move_to?("d7", @board).must_equal false
      end

    end

    describe "move along a diagonal" do

      it "is illegal" do
        @rook.can_move_to?("e5", @board).must_equal false
      end

    end

    it "can not leave his king in check" do
      @board.apply Chess::Move.new("e1 d3")
      @board.apply Chess::Move.new("a8 d6")

      @rook.can_move_to?("h4", @board).must_equal false
    end

  end

end
