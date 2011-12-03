# Copyright 2010, Iain Hecker. All Rights Reserved
require_relative './game_of_life'
require 'test/unit'

class GameOfLifeTest < Test::Unit::TestCase


  def test_block_example
    before = <<GRID.strip
....
.oo.
.oo.
....
GRID
    expected = before
    assert_equal expected, before.to_grid.next.to_s
    assert_equal before, expected.to_grid.next.to_s
  end

  def test_toad_example
    before = <<GRID.strip
......
......
..ooo.
.ooo..
......
......
GRID

expected = <<GRID.strip
......
...o..
.o..o.
.o..o.
..o...
......
GRID

    assert_equal expected, before.to_grid.next.to_s
    assert_equal before, expected.to_grid.next.to_s
  end

  def test_beacon_example
    before = <<GRID.strip
......
.oo...
.oo...
...oo.
...oo.
......
GRID

expected = <<GRID.strip
......
.oo...
.o....
....o.
...oo.
......
GRID

    assert_equal expected, before.to_grid.next.to_s
    assert_equal before, expected.to_grid.next.to_s
  end
end
