# Copyright 2010, Iain Hecker. All Rights Reserved
require_relative './game_of_life'

# generate a random grid
grid = "100x30".to_grid

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
