require_relative "floob.rb"
class CarniBreeder < Breeder
  DNA_RANGE = %w(PURPLE ORANGE LYLAC)
end


class CarniFloob < Floob

  @@breeder = CarniBreeder.new

  attr_reader :kills, :range

  def initialize(x, y, dna)
    super
    @kills = 0
    @range = 2
  end

  def try_breed
    kills > 1 ? [x_axis, y_axis] : nil
  end

  def eat
    @kills += 1
  end




end
=begin
f = CarniFloob.new(4, 5, colour: "blue")

p f.try_breed
=end
