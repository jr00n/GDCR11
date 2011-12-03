# Copyright 2010, Iain Hecker. All Rights Reserved
# Conway's Game of Life, in one line of Ruby.
# http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
# Tested and found working on Ruby 1.8.7 and 1.9.2
# The grid is spherical or "wrap around", so the left is connected to the right and top to bottom.
#
# Generate a random grid, 30 cells wide and 10 cells high
#
#   grid = "30x10".to_grid 
#
# Use a predefined grid. The lower case letter 'o' is used as an alive cell, any other character is dead.
# Newlines (\n) delimit rows in the grid.
#
#   grid = some_grid_string.to_grid
# 
# Get the next generation, with a grid you just created
#
#   grid.next
#
# Get the string representation back:
#
#   grid.to_s
String.class_eval { define_method(:to_grid) { (self =~ /\A(\d+)x(\d+)\z/ ?  (0...split('x').last.to_i).map { |_| (0...split('x').first.to_i).map { |_| rand > 0.5 } } : split("\n").map { |row| row.split(//).map { |cell_string| cell_string == "o" } }).tap { |grid| grid.class.class_eval { define_method(:next) { each { |row| row.each { |cell| cell.class.class_eval { define_method(:next?) { |neighbours| (self && (2..3).include?(neighbours.select { |me| me }.size)) || (!self && neighbours.select { |me| me }.size == 3) } } } } && enum_for(:each_with_index).map { |row, row_num| row.enum_for(:each_with_index).map { |cell, col_num| cell.next?([ at(row_num - 1).at(col_num - 1), at(row_num - 1).at(col_num), at(row_num - 1).at((col_num + 1) % row.size), row.at((col_num + 1) % row.size), row.at(col_num - 1), at((row_num + 1) % size).at(col_num - 1), at((row_num + 1) % size).at(col_num), at((row_num + 1) % size).at((col_num + 1) % row.size) ]) } } } && define_method(:to_s) { map { |row| row.map { |cell| cell ? "o" : "." }.join }.join("\n") } } } } }