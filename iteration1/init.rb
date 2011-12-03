## Conway's Game Of Life
## 
## made on the Global Day of Code Retreat
## at Finalist in Rotterdam 3 dec 2011
##

APP_ROOT = File.dirname(__FILE__)

$:unshift( File.join(APP_ROOT, 'lib') )

require 'game_of_life'

game = GameOfLife.new
game.launch!