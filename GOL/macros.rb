=begin
NOTE: all macros start from the lowest and leftmost corner, lowest first

=end



bl_h = Proc.new do |width, height, array|
  array << [width, height]
  2.times do
    width += 1
    array << [width, height]
  end

end

bl_v = Proc.new do |width, height, array|
  array << [width, height]
  2.times do
    height += 1
    array << [width, height]
  end

end

block = Proc.new do |width, height, array|
  array << [width, height]
  array << [width + 1, height]
  array << [width, height + 1]
  array << [width + 1, height + 1]
end

r_pen = Proc.new do |width, height, array|
  array << [width, height]
  array << [width, height + 1]
  array << [width, height + 2]
  array << [width + 1, height + 2]
  array << [width - 1, height + 1]
end

ALL_MACROS = {
  "blinker_h" => bl_h, "bl_v" => bl_v,
  "block" => block,
  "r_pen" => r_pen
}
=begin
array = []


ALL_MACROS["r_pen"].call(3, 4, array)

p array
=end

#--------------------------------private methods -----------------------------#
