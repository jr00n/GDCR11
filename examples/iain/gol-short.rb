String.class_eval{define_method(:to_grid){(self =~ /\A(\d+)x(\d+)\z/ ?
(0...split('x').last.to_i).map{|_| (0...split('x').first.to_i).map{|_| rand > 0.5 } } :
split("\n").map{|row| row.split(//).map{|cell_string| cell_string == "o" } }
).tap{|grid| grid.class.class_eval{define_method(:next){each{|row|
row.each{|cell| cell.class.class_eval{define_method(:next?){|neighbours|
(self && (2..3).include?(neighbours.select{|me| me }.size)) ||
(!self && neighbours.select{|me| me }.size == 3)}}}} &&
enum_for(:each_with_index).map{|row, row_num| row.enum_for(:each_with_index).map{|cell, col_num|
cell.next?([ at(row_num - 1).at(col_num - 1), at(row_num - 1).at(col_num),
at(row_num - 1).at((col_num + 1) % row.size), row.at((col_num + 1) % row.size),
row.at(col_num - 1), at((row_num + 1) % size).at(col_num - 1),
at((row_num + 1) % size).at(col_num), at((row_num + 1) % size).at((col_num + 1) % row.size) ])
} }} && define_method(:to_s){map{|row| row.map{|cell| cell ? "o" : "." }.join }.join("\n")}}}}}

# generate a random grid
grid = "100x30".to_grid
# show the grid:
puts grid.to_s
# get the next generation of the grid
new_grid = grid.next
# convert a drawn out grid to a grid
new_grid.to_s.to_grid == new_grid # returns true