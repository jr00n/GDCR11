class Game

  attr_reader :state

  def initialize(state)
    @state = state
  end

  def next
    [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  end

  def count_live_neughbours(x, y)
    count = 0
    (y-1).upto(y+1) do |yy|
      next if yy < 0 || yy >= state.size
      (x-1).upto(x+1) do |xx|
        next if xx < 0 || xx >= state[yy].size
        count += state[yy][xx]
      end
    end
    count
  end

  def apply_underpopulation
    state[1][1] = 0
  end

end
