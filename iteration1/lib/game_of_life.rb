class Grid
  def initialize(size=1000, cell_factory=lambda {})
    @size = size
    fill_grid( cell_factory )
  end
  
  def fill_grid(cell_factory)
    @cells = []
    (@size * @size).times do
      @cells << cell_factory.call
    end
  end
  
  def cells
    @cells
  end
end


describe "Grid" do
  
  it "has 1000000 number of cells when create a default grid" do
    grid = Grid.new
    grid.should have(1_000_000).cells
  end

  it "has 100 number of cells when create a grid with a size of 10" do
    grid = Grid.new 10
    grid.should have(100).cells
  end

  it "creates multiple cells" do
    cell_mock = mock
    cell_mock.should_receive(:call).exactly(4).times
    grid = Grid.new(2,cell_mock)
  end
  
  it "gives all neighbours of a cell" do
    grid.neighbours
    grid = Grid.new(3,cell_mock)
  end
end
