require_relative "board.rb"
require_relative "macros.rb"

def next_round array
  cells = array.flatten

  # anoyingly these have to be done in two seperate iterations;
  # the cells cannot check and update during the same iteration or else
  # some of the cells being checked will already be living in the next round.
  # the only possible soloution I see is, like, multythreading? but fuck that
  cells.each do |i|
    i.check
  end
  cells.each do |i|
    i.update
  end
end

def rounds board, n
  n.times do
    system 'cls'

    next_round board

    display_b board

    sleep 0.1
  end
end


def rounds_till_stable board
  count = 0
  states = [make_string(board)]
  loop do

    next_round board

    count += 1

    str = make_string board

    break if states.include?(str)

    states << str

  end

  display_b board
  count
end

#------------------------------types of new game---------------------------#

def newgame num
  cells = make_b

  rounds cells, num

end

def newgame_blank num, specials = []
  cells = make_b 55, 55, DEAD, specials

  rounds cells, num
end

def newgame_for_science specials=[]
  cells = make_b 25, 25, DEAD, specials

  rounds_till_stable cells
end
