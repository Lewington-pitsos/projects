class Breeder
  ERROR_RATE = 70

  def initialize
    @dna_range = {
      colour: %w(RED BLUE GREEN)
    }.freeze
  end

  def dna_from floob_dna
    floob_dna.keys.each_with_object({}) do |property, new_dna|
      if rand(0..101) < ERROR_RATE
        new_dna[property] = @dna_range[property].sample
      else
        new_dna[property] = floob_dna[property]
      end
    end
  end
end

#---------------------------------------------------------------------------#

class Floob

  attr_reader :colour, :symbol, :x_axis, :y_axis, :dna

  def initialize x_axis, y_axis, dna
    @x_axis = x_axis
    @y_axis = y_axis

    @colour = dna[:colour]
    @symbol = colour[0]

    @dna = dna
    @breeder = Breeder.new
  end

  def new_position array
    self.x_axis = array[0]
    self.y_axis = array[1]
  end

  def try
    direction
  end

  def try_breed
    [[x_axis, y_axis], direction]
  end

  def breed positions
    positions.map do |pos|
      Floob.new(pos[0], pos[1], @breeder.dna_from(dna))
    end
  end

  private

  def direction
    [
      [x_axis + 1, y_axis],
      [x_axis - 1, y_axis],
      [x_axis, y_axis + 1],
      [x_axis, y_axis - 1]
    ].sample
  end

  attr_writer :x_axis, :y_axis

end
