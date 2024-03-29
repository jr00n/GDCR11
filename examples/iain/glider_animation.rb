# Copyright 2010, Iain Hecker. All Rights Reserved
require_relative './game_of_life'

# generate pattern glider, which continues forever
grid = <<GRID.to_grid
..............
..o...........
...o..........
.ooo..........
..............
..............
..............
..............
GRID

interrupted = false
generations = 0
trap("INT") { puts "\rExiting after #{generations} generations..."; interrupted = true }
until interrupted do
  system "clear"
  puts grid.to_s
  grid = grid.next
  generations += 1
  sleep 0.1
end
