require_relative "floob.rb"

class CarniBreeder < Breeder
  def initialize
    @dna_range= {
      colour: %w(ORANGE, PURPLE, TEAL)
    }.freeze
  end
end


class CarniFloob < Floob



  attr_reader :kills, :range

  def initialize(x, y, dna)
    super
    @kills = 3
    @range = 2
    @breeder = CarniBreeder.new
  end

  def try_breed
    if kills > 1
      [[x_axis, y_axis]]
    else
      nil
    end
  end

  def breed position
    [CarniFloob.new(position[0][0], position[0][1], @breeder.dna_from(dna))]
  end

  def eat
    @kills += 1
  end

end
=begin
f = CarniFloob.new(4, 5, colour: "blue")

p f.try_breed
=end
