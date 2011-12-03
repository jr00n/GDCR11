require "minitest/autorun"
require_relative "../game"

describe Game do
  it "returns its state" do
    Game.new([]).state.must_equal([])
    Game.new([[0, 0], [0, 0]]).state.must_equal([[0, 0], [0, 0]])
  end

  describe "#apply_underpopulation" do
    it "removes cells with fewer than two live neighbours" do
      game = Game.new([[0, 0, 0],
                       [0, 1, 0],
                       [0, 0, 0]])
      game.apply_underpopulation

      game.state[1][1].must_equal(0)
    end


  end

  describe "#count_live_neighbours" do
    it "coutns the live neighbours" do
      Game.new([[0, 1, 1],
                [1, 0, 0],
                [0, 0, 1]]).count_live_neughbours(1, 1).must_equal 4
    end

    it "counts excluding negative indices" do
      Game.new([[0, 1, 1],
                [1, 0, 0],
                [0, 0, 1]]).count_live_neughbours(0, 0).must_equal 2
    end

    it "counts excluding invalid indices" do
      Game.new([[0, 1, 1],
                [1, 0, 0],
                [0, 0, 1]]).count_live_neughbours(2, 1).must_equal 3
    end

  end
end
