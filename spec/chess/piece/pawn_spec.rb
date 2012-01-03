require "minitest/autorun"
require_relative "../../../lib/chess"

describe Chess::Piece::Pawn do

  before do
    @board = Chess::Board.new
  end

  describe "can_move_to?(square, board)" do

    describe "the white pawn" do
  
      before do
        @pawn = @board.piece_on "d2"
      end

      describe "to move forward to the square immediately in front of it on the same file" do

        it "can if the square is unoccupied" do
          @pawn.can_move_to?("d3", @board).must_equal true
        end

        it "can not if the square is occupied" do
          @board.apply Chess::Move.new("d7 d3")

          @pawn.can_move_to?("d3", @board).must_equal false
        end

      end

      describe "on its first move to move forward two squares along the same file" do

        it "can provided both squares are unoccupied" do
          @pawn.can_move_to?("d4", @board).must_equal true
        end

        it "can not if first square is occupied" do
          @board.apply Chess::Move.new("d7 d3")

          @pawn.can_move_to?("d4", @board).must_equal false
        end

        it "can not if second square is occupied" do
          @board.apply Chess::Move.new("d7 d4")
          
          @pawn.can_move_to?("d4", @board).must_equal false
        end

        it "can not if it is not its first move" do
          @board.apply Chess::Move.new("d2 d3")

          @pawn.can_move_to?("d5", @board).must_equal false
        end

      end

      describe "to move to a square which is diagonally in front of it on an adjacent file" do

        it "can if it is occupied by an opponent's piece" do
          @board.apply Chess::Move.new("e7 e3")

          @pawn.can_move_to?("e3", @board).must_equal true
        end

        it "can not if it is occupied by a piece of the same color" do
          @board.apply Chess::Move.new("e2 e3")

          @pawn.can_move_to?("e3", @board).must_equal false
        end

        it "can not if it is unoccupied" do
          @pawn.can_move_to?("e3", @board).must_equal false
        end

      end

      it "can not leave its king in check" do
        @board.apply Chess::Move.new("c8 b4")

        @pawn.can_move_to?("d3", @board).must_equal false
      end

    end

    describe "the black pawn" do
  
      before do
        @pawn = @board.piece_on "d7"
      end

      describe "to move forward to the square immediately in front of it on the same file" do

        it "can if the square is unoccupied" do
          @pawn.can_move_to?("d6", @board).must_equal true
        end

        it "can not if the square is occupied" do
          @board.apply Chess::Move.new("d2 d6")

          @pawn.can_move_to?("d6", @board).must_equal false
        end

      end

      describe "on its first move to move forward two squares along the same file" do

        it "can provided both squares are unoccupied" do
          @pawn.can_move_to?("d5", @board).must_equal true
        end

        it "can not if first square is occupied" do
          @board.apply Chess::Move.new("d2 d6")

          @pawn.can_move_to?("d5", @board).must_equal false
        end

        it "can not if second square is occupied" do
          @board.apply Chess::Move.new("d2 d5")

          @pawn.can_move_to?("d5", @board).must_equal false
        end

        it "can not if it is not its first move" do
          @board.apply Chess::Move.new("d7 d6")

          @pawn.can_move_to?("d4", @board).must_equal false
        end

      end

      describe "to move to a square which is diagonally in front of it on an adjacent file" do

        it "can if it is occupied by an opponent's piece" do
          @board.apply Chess::Move.new("e2 e6")

          @pawn.can_move_to?("e6", @board).must_equal true
        end

        it "can not if it is occupied by a piece of the same color" do
          @board.apply Chess::Move.new("e7 e6")

          @pawn.can_move_to?("e6", @board).must_equal false
        end

        it "can not if it is unoccupied" do
          @pawn.can_move_to?("e6", @board).must_equal false
        end

      end

    end

  end

end

