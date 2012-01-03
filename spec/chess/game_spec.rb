require "minitest/autorun"
require_relative "../../lib/chess"

describe Chess::Game do

  describe "#is_move_legal?(an_move)" do

    before do
      @game = Chess::Game.new
    end

    it "returns false when there is no piece on the origin square" do
      move = Chess::Move.new "a3 a4"
      @game.is_move_legal?(move).must_equal false
    end

    it "returns false when the destination square is equal to the origin square" do
      move = Chess::Move.new "a1 a1"
      @game.is_move_legal?(move).must_equal false
    end

    describe "when there is a piece on the origin square and origin and destination squares are different" do

      it "returns true when the move is legal" do
        move = Chess::Move.new "a2 a3"
        @game.is_move_legal?(move).must_equal true
      end

      it "returns false when the move is illegal" do
        move = Chess::Move.new "a2 a6"
        @game.is_move_legal?(move).must_equal false
      end

    end

  end

end
