class World
  def initialize(alive_cells=[])
    @alive_cells = alive_cells
  end
  
  def alive_cell?(row,col)
    @alive_cells.each {|cell|return true if cell[0] == row && cell[1] == col}
    false
  end
  
  def number_of_alive_neighbours(row,col)
    count = 0
    count += 1 if alive_cell?(row-1,col-1)
    count += 1 if alive_cell?(row-1,col) 
    count += 1 if alive_cell?(row-1,col+1)
    count += 1 if alive_cell?(row,col-1)
    count += 1 if alive_cell?(row,col+1)
    count += 1 if alive_cell?(row+1,col-1)
    count += 1 if alive_cell?(row+1,col)
    count += 1 if alive_cell?(row+1,col+1)
    count
  end
end

describe "World" do
  
  it "should give a dead cell at pos 0,0 on a new empty world" do
    world = World.new
    world.should_not be_alive_cell(0,0)
  end
  
  it "should give a living cell at pos 0,0 on a new world with one cell at 0,0" do
    world = World.new([[0,0]])
    world.should be_alive_cell(0,0)
  end
  
  it "should count 0 alive neighbours arround cell at pos 0,0 on a new empty world" do
    world = World.new
    world.number_of_alive_neighbours(0,0).should eq(0)
  end
  
  it "should count 8 alive neighbours arround cell at pos 0,0 on a new world with eight cells" do
    world = World.new([[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]])
    world.number_of_alive_neighbours(0,0).should eq(8)
  end
end