# Copyright 2010, Iain Hecker. All Rights Reserved
# The oneliner, but now with newlines, indenting and documentation

# Within the following closure the class String is "self"
String.class_eval {
  # define an instance method
  define_method(:to_grid) {
    # check if this string contains dimensions
    (self =~ /\A(\d+)x(\d+)\z/ ? 
      # Generate a range for the last part of the dimensions and change each item.
      (0...split('x').last.to_i).map { |_|
        # And also for the first part of the dimensions, thus making a 2-dimensional array (aka "the grid")
        (0...split('x').first.to_i).map { |_|
          # random true or false.
          rand > 0.5
        }
      } :
      # if it's not dimensions, assume it's a completly drawn grid, which must be splitted in rows
      split("\n").map { |row|
        # and every row splitted on every character
        row.split(//).map { |cell_string|
          # it's true (alive) when it's a lower case 'o'
          cell_string == "o"
        }
      }
    # modify (but always return the original object) with the result (which is the grid)
    ).tap { |grid|
      # the class of the grid becomes "self"
      grid.class.class_eval {
        # and define the instance method "next" on it
        define_method(:next) {
          # for each row
          each { |row|
            # and each cell in each row
            row.each { |cell|
              # become the class of the content (TrueClass or FalseClass)
              cell.class.class_eval {
                # and define the instance method "next?", which accepts neighbours to know if it should die or live
                define_method(:next?) { |neighbours|
                  # self is true or false (instances of resp. TrueClass and FalseClass), so this expression just returns a new boolean
                  (self && (2..3).include?(neighbours.select { |me| me }.size)) || (!self && neighbours.select { |me| me }.size == 3)
                }
              }
            }
          # map with index, is shorter in Ruby 1.9, but this strange construction works also in Ruby 1.8
          } && enum_for(:each_with_index).map { |row, row_num|
            # same, we're dealing a 2-dimensional array, remember?
            row.enum_for(:each_with_index).map { |cell, col_num|
              # call the next?-method we defined about 10 lines earlier and find all its neighbours
              cell.next?([
                        at(row_num - 1).at(col_num - 1),
                        at(row_num - 1).at(col_num),
                        at(row_num - 1).at((col_num + 1) % row.size),
                        row.at((col_num + 1) % row.size),
                        row.at(col_num - 1),
                        at((row_num + 1) % size).at(col_num - 1),
                        at((row_num + 1) % size).at(col_num),
                        at((row_num + 1) % size).at((col_num + 1) % row.size)
              ])
            }
          }
        # and define the method to_s
        } && define_method(:to_s) {
          # which loops
          map { |row|
            # the 2-dimensional array
            row.map { |cell|
              # and replaces booleans with strings
              cell ? "o" : "."
            # and join a row together
            }.join
          # and join the lines together
          }.join("\n")
        }
      }
    }
  }
}