require_relative "./cell.rb"

class Board

  def initialize start, n
    @start = start

    #len represents the number of cells we evaluate aech time
    @len = start.length - 2
    @prev = start
    @count = 0

    run n
  end


private

  attr_reader :len, :prev, :count

  def new_row
    row = [" "]
    len.times do |i|
      cell = Cell.new(prev[i], prev[i+1], prev[i+2])
      row << cell.state
    end
    row << " "
  end

  def run num
    num.times do
      @count += 1
      print "% -7d" % [count]
      @prev = new_row
      prev.each {|i| print i}
      puts
    end
  end

end

start = Array.new(70, " ") + ["0"] + Array.new(70, " ")

Board.new start, 130
