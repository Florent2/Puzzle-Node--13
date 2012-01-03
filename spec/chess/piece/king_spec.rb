require "minitest/autorun"
require_relative "../../../lib/chess"

describe Chess::Piece::King do

  before do
    @board = Chess::Board.new
    @board.apply Chess::Move.new("e1 e4")
    @king = @board.piece_on "e4"
  end

  describe "can_move_to?(square, board)" do

    it "can not move to an square occupied by a piece of the same color" do
      @board.apply Chess::Move.new("e2 e3")
      @king.can_move_to?("e3", @board).must_equal false
    end

    it "can move to an square occupied by a piece of the other color" do
      @board.apply Chess::Move.new("e7 e5") 

      @king.can_move_to?("e5", @board).must_equal true
    end

    it "can not go in check" do
      @board.apply Chess::Move.new("a8 d6")

      @king.can_move_to?("d5", @board).must_equal false
    end

    describe "move along a row" do

      it "can move to the left column" do
        @king.can_move_to?("d4", @board).must_equal true
      end

      it "can move to the right column" do
        @king.can_move_to?("f4", @board).must_equal true
      end

      it "can not move multiple columns" do
        @king.can_move_to?("g4", @board).must_equal false
      end

    end

    describe "move along a column" do

      it "can move to the up row" do
        @king.can_move_to?("e5", @board).must_equal true
      end

      it "can move to the down row" do
        @king.can_move_to?("e3", @board).must_equal true
      end

      it "can not move multiple rows" do
        @board.apply Chess::Move.new("e2 a5")

        @king.can_move_to?("e2", @board).must_equal false
      end

    end

    describe "move along a diagonal" do

      it "can move up right" do
        @king.can_move_to?("f5", @board).must_equal true
      end

      it "can move down right" do
        @king.can_move_to?("f3", @board).must_equal true
      end

      it "can move up left" do
        @king.can_move_to?("d5", @board).must_equal true
      end

      it "can move down left" do
        @king.can_move_to?("d3", @board).must_equal true
      end

      it "can not move along multiple squares" do
        @board.apply Chess::Move.new("g2 a5")

        @king.can_move_to?("g2", @board).must_equal false
      end

    end

  end

end
