require "minitest/autorun"
require_relative "../../../lib/chess"

describe Chess::Piece::Knight do

  before do
    @board  = Chess::Board.new
    @board.apply Chess::Move.new("b1 e5")
    @knight = @board.piece_on "e5"
  end

  describe "can_move_to?(square, board)" do

    it "can move 2 squares up and 1 right" do
      @knight.can_move_to?("f7", @board).must_equal true
    end

    it "can move 2 squares up and 1 left" do
      @knight.can_move_to?("d7", @board).must_equal true
    end

    it "can move 1 square up and 2 right" do
      @knight.can_move_to?("g6", @board).must_equal true
    end

    it "can move 1 square up and 2 left" do
      @knight.can_move_to?("c6", @board).must_equal true
    end

    it "can move 2 squares down and 1 right" do
      @knight.can_move_to?("f3", @board).must_equal true
    end

    it "can move 2 squares down and 1 left" do
      @knight.can_move_to?("d3", @board).must_equal true
    end

    it "can move 1 square down and 2 right" do
      @knight.can_move_to?("g4", @board).must_equal true
    end

    it "can move 1 square down and 2 left" do
      @knight.can_move_to?("c4", @board).must_equal true
    end

    it "can leap over other pieces" do
      @board.apply Chess::Move.new("d2 d4")

      @knight.can_move_to?("c4", @board).must_equal true
    end

    it "can not leave its king in check" do
      @board.apply Chess::Move.new("e1 e3")
      @board.apply Chess::Move.new("a8 e6")

      @knight.can_move_to?("c4", @board).must_equal false
    end

  end

end
