require_relative "floob.rb"
require_relative "board.rb"
require_relative "carnifloob.rb"
class Farm
  attr_reader :floobs, :preditors, :free

  def initialize x, y, floob_num, pred_num
    @x = x
    @y = y

    @free = (0..x).to_a.product((0..y).to_a)
    @occupied = []
    @floobs = []
    @preditors = []

    populate floob_num, Floob, floobs, colour: "RED"
    pred_populate pred_num, CarniFloob, preditors, colour: "PURPLE"

    @board = Board.new(x + 1, y + 1)
  end



  def show_board

    system "cls"

    board.reset

    add_floobs

    board.display
  end

  def move_floobs
    floobs.each  do |floob|
      position = [floob.x_axis, floob.y_axis]

      count = 0
      while count < 10
        attempt = floob.try
        p attempt
        if !occupied.include?(attempt) && within_bounds(attempt)
          make_moves floob, position, attempt
          break
        end

        count += 1
      end
    end
  end

  def floobs_eat
    preditors.each do |pred|
      area = eat_range pred.x_axis, pred.y_axis, pred.range

      floobs.each_with_index do |floob, index|
        if area.include?([floob.x_axis, floob.y_axis]) && floob.class == Floob
          occupied.delete([floob.x_axis, floob.y_axis])
          floobs[index] = nil
          pred.eat
        end
      end

    floobs.delete(nil)

    end
  end

  def new_generation
    temp = floobs.dup

    floobs.each do |floob|
      position = [floob.x_axis, floob.y_axis]

      count = 0
      while count < 10
        attempt = floob.try_breed
        unless attempt
          temp.delete(floob)
          occupied.delete([floob.x_axis, floob.y_axis])
          break
        end
        if (occupied & attempt).size == 1 &&
           attempt.all? { |i| within_bounds(i) }
          breed_offspring floob, position, attempt, temp
          break
        end
        count += 1
      end
    end

    self.floobs = temp
    self.preditors = floobs & preditors
  end

  private

  attr_reader :board, :occupied, :x, :y
  attr_writer :floobs, :preditors

  def populate num, object_class, list, dna
    num.times do
      xax, yax = plant_at free.sample
      list << object_class.new(xax, yax, dna)
    end
  end

  def pred_populate num, object_class, extra_list, dna
    num.times do
      xax, yax = plant_at free.sample
      pred = object_class.new(xax, yax, dna)
      floobs << pred
      extra_list << pred
    end
  end

  def within_bounds position
    (position[0] < x && position[0] > 0) &&
      (position[1] < y && position[1] > 0)
  end

  def plant_at position
    @occupied << position
    @free.delete(position)
  end

  def add_floobs
    floobs.each { |floob| board.add(floob) }
  end

  def make_moves floob, position, attempt
    occupied.delete(position)
    floob.new_position(attempt)
    occupied << attempt
  end

  def breed_offspring floob, position, attempt, temp
    occupied.delete(position)

    temp.delete(floob)

    new_floobs = floob.breed(attempt)

    new_floobs.each { |i| temp << i }

    attempt.each { |i| occupied << i }
  end

  def eat_range x, y, range
    dist = 1

    area = [[x, y]]

    range.times do
      area << [x + dist, y]
      area << [x - dist, y]
      area << [x, y + dist]
      area << [x, y - dist]
      dist += 1
    end
    area
  end
end
w = Farm.new(20, 20, 1, 0)




8.times do
  20.times do
    w.move_floobs

    w.show_board

    sleep 0.3

    w.floobs_eat

    w.show_board

    sleep 0.3
  end

  w.new_generation

  w.show_board

end
