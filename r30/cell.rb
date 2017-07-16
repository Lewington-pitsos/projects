class Cell

  RULES = {
    "000" => " ",
    "00 " => "0",
    "0 0" => " ",
    "0  " => "0",
    " 00" => " ",
    " 0 " => "0",
    "  0" => "0",
    "   " => " "

  }.freeze

  attr_reader :state

  def initialize(a, b, c, state= " ")
    @a = a
    @b = b
    @c = c
    @state = state
    convert
  end

  def convert
    @state = RULES[check_state]
  end

  private

  attr_reader :a, :b, :c

  def check_state
    a + b + c
  end
end
