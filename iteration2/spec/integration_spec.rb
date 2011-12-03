require "minitest/autorun"
require_relative "../game"

describe "Game of Life" do

  it "kills the lone cell" do
    Game.new([[0, 0, 0],
              [0, 1, 0],
              [0, 0, 0]]).next.must_equal([[0] * 3] * 3)
  end

  it "it preserves the stable state" do
    stable = [[0, 1, 0],
              [1, 0, 1],
              [0, 1, 0]]
    Game.new(stable).next.must_equal(stable)
  end


end
