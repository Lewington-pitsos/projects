require_relative "play.rb"

def living_cells

  answer = ''

  loop do
    puts "which cells should start alive? \n
    Macros: #{ALL_MACROS.keys} \n
    Format: |intiger,intiger | e.g. 3,7,macro 4,7,macro 3,3"

    answer = gets.chomp
    break if validator answer

    puts "invalid input"
  end

  to_array answer
end

def validator str
  str += " "
  !!str.match(/\A(\d+,\d+(,[a-z_]+)? )+\z/)
end

# splts the string into entries |width,height,macro|, and further splits
# these into arrays
# if there is no macro just add that array to the main array
# otherwise make a new array containing all the arrays that result from
# that macro and add all of these to array
# NOTE: we need to make sure nothing goes off the edge
def to_array str
  array = []
  str.split().each do |i|
    entry = i.split(",")

    width = entry[0].to_i
    height = entry[1].to_i

    if entry.length == 2
      array << [width, height]
    else
      ALL_MACROS[entry[2]].call(width, height, array)
    end
  end

  array
end

# p validator "3,7,macro 4,7 3,3"

# p to_array "3,4,blinker_h, 6,6 7,7,blinker_v"



alive = to_array("13,12,r_pen 10,10,r_pen")

p newgame_for_science alive
