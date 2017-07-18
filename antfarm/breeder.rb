class Breeder

  ERROR_RATE = 50
  DNA_RANGE = {
    colour: ["RED", "BLUE", "GREEN"]
  }

  def dna_from floob_dna

    new_dna = floob_dna.keys.each_with_object({}) do |property, new_dna|

      if rand(0..101) < ERROR_RATE
        new_dna[property] = DNA_RANGE[property].sample
      else
        new_dna[property] = floob_dna[property]
      end

    end


  end

end

=begin
z = Breeder.new

w = Floob.new(10, 12, {colour: "RED"})

a = []

100.times do
  a << Floob.new(5, 5, z.dna_from(w))
end

p a.count {|i| i.colour == "BLUE"}
=end
