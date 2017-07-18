class Board
  attr_reader :board

  def initialize x, y
    @x = x
    @y = y

    @board = newboard
  end

  def newboard
    array = []

    y.times do
      mini = []
      x.times do
        mini << " "
      end
      array << mini
    end

    array
  end

  def reset
    self.board = newboard
  end

  def add floob
    board[floob.y_axis][floob.x_axis] = floob.symbol
  end

  def display
    board.each do |row|
      row.each { |i| print i }
      puts
    end
  end

  private

  attr_writer :board
  attr_reader :x, :y
end
