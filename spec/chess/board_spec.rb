require "minitest/autorun"
require_relative "../../lib/chess"

describe Chess::Board do

  before do
    @board = Chess::Board.new
  end

  describe "#new(io)" do

    describe "when no io object is passed" do

      it "initializes the board with the standard initial setup" do
        @board.piece_on("d5").must_be_nil
      end

      it "initializes the board with the standard initial setup" do
        @board.piece_on("a1").must_be_instance_of Chess::Piece::Rook
        @board.piece_on("a1").color.must_equal :white
      end

      it "initializes the board with the standard initial setup" do
        @board.piece_on("f7").must_be_instance_of Chess::Piece::Pawn
        @board.piece_on("f7").color.must_equal :black
      end

    end

    describe "when the io object is a file" do
      # TODO
    end

  end

  describe "#apply(move)" do

    it "moves the piece to the destination square" do
      piece = @board.piece_on "a2"
      move  = Chess::Move.new "a2 a3"

      @board.apply move
      @board.piece_on("a3").must_equal piece
    end

    it "removes the piece from the origin square" do
      move = Chess::Move.new "a2 a3"

      @board.apply move
      @board.piece_on("a2").must_be_nil
    end

    it "does not prevent an illegal move" do
      piece = @board.piece_on "a2"
      move = Chess::Move.new "a2 g8"

      @board.apply move
      @board.piece_on("g8").must_equal piece
    end

  end

  describe "#piece_on(square)" do

    it "returns nil if there is no piece on this square" do
      @board.piece_on("d4").must_be_nil
    end

    it "returns a Piece instance corresponding to the piece occupying the square" do
      @board.piece_on("a1").must_be_instance_of Chess::Piece::Rook
      @board.piece_on("a1").color.must_equal :white
    end

    it "correctly returns the piece when it has changed its square" do
      piece = @board.piece_on("a1")
      piece.square = "g5"

      @board.piece_on("g5").must_equal piece
    end

  end

  describe "#squares_unoccupied_between?(orig_square, dest_square)" do

    describe "when the squares are on the same row" do

      it "returns true when the squares are adjacent" do
        @board.squares_unoccupied_between?("e4", "f4").must_equal true
      end

      it "returns true when the intermediate squares are unoccupied" do
        @board.squares_unoccupied_between?("e4", "h4").must_equal true
      end

      it "returns false when at least one intermediate square is occupied" do
        @board.apply Chess::Move.new("a2 f4")

        @board.squares_unoccupied_between?("e4", "h4").must_equal false
      end

    end

    describe "when the squares are on the same column" do

      it "returns true when the squares are adjacent" do
        @board.squares_unoccupied_between?("e4", "e5").must_equal true
      end

      it "returns true when the intermediate squares are unoccupied" do
        @board.squares_unoccupied_between?("e3", "e6").must_equal true
      end

      it "returns false when at least one intermediate square is occupied" do
        @board.apply Chess::Move.new("a2 e5")

        @board.squares_unoccupied_between?("e2", "e6").must_equal false
      end

    end

    describe "when the squares are on the same diagonal" do

      it "returns true when the squares are adjacent on the same diagonal" do
        @board.squares_unoccupied_between?("e4", "f5").must_equal true
      end

      it "returns true when the intermediate squares are unoccupied" do
        @board.squares_unoccupied_between?("d4", "f6").must_equal true
      end

      it "returns false when at least one intermediate square between is occupied" do
        @board.apply Chess::Move.new("a2 e5")

        @board.squares_unoccupied_between?("c3", "f6").must_equal false
      end

    end

  end

end
