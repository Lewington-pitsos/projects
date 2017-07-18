class Breeder
  ERROR_RATE = 20
  DNA_RANGE = {
    colour: %w(RED BLUE GREEN)
  }.freeze

  def dna_from floob_dna
    floob_dna.keys.each_with_object({}) do |property, new_dna|
      if rand(0..101) < ERROR_RATE
        new_dna[property] = DNA_RANGE[property].sample
      else
        new_dna[property] = floob_dna[property]
      end
    end
  end
end

#---------------------------------------------------------------------------#

class Floob
  @@breeder = Breeder.new

  attr_reader :colour, :symbol, :x_axis, :y_axis, :dna

  def initialize x_axis, y_axis, dna
    @x_axis = x_axis
    @y_axis = y_axis

    @colour = dna[:colour]
    @symbol = colour[0]

    @dna = dna

    directions
  end

  def new_position array
    self.x_axis = array[0]
    self.y_axis = array[1]
  end

  def try
    [@up, @down, @east, @west].sample
  end

  def try_breed
    [[x_axis, y_axis], [@up, @down, @east, @west].sample]
  end

  def breed positions
    positions.map do |pos|
      Floob.new(pos[0], pos[1], @@breeder.dna_from(dna))
    end
  end

  private

  attr_reader :up, :down, :east, :west

  attr_writer :x_axis, :y_axis

  def directions
    @up = [x_axis + 1, y_axis]
    @down = [x_axis - 1, y_axis]
    @east = [x_axis, y_axis + 1]
    @west = [x_axis, y_axis - 1]
  end
end
