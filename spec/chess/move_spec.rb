require "minitest/autorun"
require_relative "../../lib/chess"

describe Chess::Move do

  describe "#origin_square" do

    it "returns the origin square" do
      move = Chess::Move.new "a2 a3"
      move.origin_square.must_equal "a2"
    end

  end

  describe "#destination_square" do

    it "returns the destination square" do
      move = Chess::Move.new "a2 a3"
      move.destination_square.must_equal "a3"
    end

  end

  describe "#rows_nb_changed" do

    it "returns the number of rows between the origin and destination squares" do
      move = Chess::Move.new "a2 a4"
      move.rows_nb_changed.must_equal 2
    end

  end

  describe "#columns_nb_changed" do

    it "returns the absolute number of columns between the origin and destination squares" do
      move = Chess::Move.new "c4 a4"
      move.columns_nb_changed.must_equal 2
    end

  end

end
