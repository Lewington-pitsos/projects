LIVING = "0"
DEAD = " "

RANDOM = [LIVING, DEAD]
=begin
must know:
  (1)It's location
  (2)some peice of data representing all the squares around it
  (3) it's state (living or dead)
  (4) it's future (state next round)
    NOTE: this is to make iterating through cells faster,
          Hopefully only once per round.


Must do:
  (1) change it's state to future
  (2) check if one of it's neighbouring squares is occuped or not
  (3) change it's future depending on that check

=end
class Cell
  attr_reader :state, :touch, :future

  def initialize state=RANDOM, touch=[]
    @state = state

    # each round each cell will (1) change its state to future and (2) work
    # out its future for next round. To start with state and future are the
    # same.
    @future = state

    @touch = touch
  end

  def update
    @state = future
  end

  #work out how many living cells the currenty cell is touching
  def check
    count = 0

    touch.each {|i| count += 1 if i.state == LIVING}

  # the update of the state to future happens second so state still represents
  # last round
  if (count == 2 && state == LIVING) || count == 3
    survive
  else
    die
  end

  end

  def die
    @future = DEAD
  end

  def survive
    @future = LIVING
  end

end
