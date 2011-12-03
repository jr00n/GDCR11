class Cell
  attr_accessor :row, :col
end

class Rule

  def self.apply(state, alive_neighbours_count)
    if new(state, alive_neighbours_count).lives?
      :spawn
    else
      :shoot
    end
  end

  def initialize(state, alive_neighbours_count)
    lives?
  end

  def lives?
    !dies? or spawning? or stays_alive?
  end

  def dies?
    overpopulated? || underpopulated?
  end

  def spawning?
    @alive_neighbours_count == 3
  end

  def stays_alive?
    @alive_neighbours_count == 2 && alive?
  end

  def alive?
    @state == 'living'
  end

  def overpopulated?
    @alive_neighbours_count > 3
  end

  def underpopulated?
    @alive_neighbours_count < 2
  end

end

class Visor

  def grid=(grid)
  end

  def action(state = state)
    Rule.apply(state, alive_neighbours_count)
  end

  def alive_neighbours_count
  end

  def state
  end

end

describe Visor do

  it "should accept a grid" do
    subject.grid = stub
  end

  xit "should know the neighbours for a cell" do

  end

  context 'living cells' do

    before { subject.stub(:state).and_return 'living' }

    it "should ask the rule class for what to do" do
      subject.stub(:alive_neighbours_count).and_return { 1 }
      subject.action.should == :shoot

      subject.stub(:alive_neighbours_count).and_return { 2 }
      subject.action.should == :shoot

      subject.stub(:alive_neighbours_count).and_return { 2 }
      subject.action.should == :shoot
    end

  end
end

describe Rule do

  it "should know if there's overpopulation" do
    Rule.new(4).should      be_overpopulated
    Rule.new(5).should      be_overpopulated

    Rule.new(3).should_not  be_overpopulated
  end

  it "should know if there's underpopulation" do
    Rule.new(1).should      be_underpopulated

    Rule.new(2).should_not  be_underpopulated
  end

  it "should know if there's going to be a newborn" do
    Rule.new(3).should      be_spawning
    Rule.new(4).should_not  be_spawning
    Rule.new(2).should_not  be_spawning
  end

end