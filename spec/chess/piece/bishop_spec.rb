require "minitest/autorun"
require_relative "../../../lib/chess"

describe Chess::Piece::Bishop do

  before do
    @board = Chess::Board.new
    @board.apply Chess::Move.new("c1 a3")
    @bishop = @board.piece_on "a3"
  end

  describe "can_move_to?(square, board)" do

    describe "move along a diagonal" do

      it "can move along empty squares" do
        @bishop.can_move_to?("d6", @board).must_equal true
      end

      it "can not move to a square occupied by a piece of the same color" do
        @bishop.can_move_to?("b2", @board).must_equal false
      end

      it "can move to a square occupied by a piece of the other color" do
        @bishop.can_move_to?("e7", @board).must_equal true
      end

      it "can not move to a square if intermediate square is occupied" do
        @bishop.can_move_to?("f8", @board).must_equal false
      end

      it "can not leave his king in check" do
        @board.apply Chess::Move.new("a3 d4")
        @board.apply Chess::Move.new("e1 d3")
        @board.apply Chess::Move.new("a8 d6")

        @bishop.can_move_to?("e5", @board).must_equal false
      end

    end

    describe "move along a column" do

      it "is illegal" do
        @bishop.can_move_to?("a6", @board).must_equal false
      end

    end

    describe "move along a row" do

      it "is illegal" do
        @bishop.can_move_to?("c3", @board).must_equal false
      end

    end

  end

end
