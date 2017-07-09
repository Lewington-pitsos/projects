require_relative "./cells.rb"

def mutual_add cell1, cell2
  cell1.touch << cell2
  cell2.touch << cell1
end


# by default the board is set to make the state of each cell random, but
# this can be changed by passing in a specific state argument
# it cam also take what is bacally an array of indexes, which pick out
# cells whose starting state is to be determiend specially
def make_b width=30, height=10, state=RANDOM, specials = []

  array = []

  height.times do |i|
    mini = []
    prev = nil
    index = i - 1


    # (1) create a new cell touching the previous,
    # (1.1) add the cell directly above to touch as well if it exists
    # (2) add that cell to mini
    # (3) add that cell to the touch of previous
    # (4) set previous to the current cell
    width.times do |q|

      curr= make_cell q, i, state, specials

      # if index is 0 or higher, then this isn't the first row, which means
      # that a cell exists derectly above this one. Both should be added to
      # each others touch
      aboves index, array, curr, q


      mini << curr
      if prev
        mutual_add curr, prev
      end
      prev = curr
    end
    array << mini
  end

  array
end

# this checks if the living cells aray contains the cell in question. if not
# it's state is set according to state, otherwise it is set to living
def make_cell q, i, state, specials
  if specials.include?([q, i])
    return Cell.new(LIVING, [])
  else
    if state == RANDOM
      return Cell.new(RANDOM.sample, [])
    else
      return Cell.new(state, [])
    end
  end

end

def display_b board
  pad_length = (board[0].length)
  heading = "STATE:"
  pad = "-"
  puts heading.center(pad_length, pad)

  board.each do |row|
    row.each {|cell| print cell.state}
    puts
  end

  puts (pad * pad_length)
end

# grabs the 3 cells above the current cell and adds them to touch mutually
# also corrects for cells at the board edges (i.e. depending on q)
def aboves index, array, curr, q
  if index > -1
    above = array[index][q]
    mutual_add curr, above

    #correcting for edge cells
    if q > 0
      ab_before = array[index][q-1]
      mutual_add curr, ab_before
    end

    if q < (array[0].length) - 1
      ab_after = array[index][q+1]
      mutual_add curr, ab_after
    end

  end
end

def display_b_touch board
  pad_length = (board[0].length)
  heading = "STATE:"
  pad = "-"
  puts heading.center(pad_length, pad)

  board.each do |row|
    row.each {|cell| print cell.touch.length}
    puts
  end

  puts (pad * pad_length)
end

#this is for checking if the board state is the same as some other board state
def make_string board
  str = ''
  board.flatten.each do |i|
    str += i.state
  end
  str
end

=begin
cells = make_b

display_b_touch cells
=end
