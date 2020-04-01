class CardExt < Card
  def to_s
    self.values.to_s
  end
end

cards = [
  [CardExt.new(1, 1, 1, 1), CardExt.new(1, 2, 1, 2), CardExt.new(1, 1, 2, 2)],
  [CardExt.new(2, 1, 1, 1), CardExt.new(2, 2, 1, 2), CardExt.new(2, 1, 2, 2)],
  [CardExt.new(3, 1, 1, 1), CardExt.new(3, 1, 1, 2), CardExt.new(3, 1, 3, 2)],
  [CardExt.new(2, 2, 2, 2), CardExt.new(1, 2, 2, 2), CardExt.new(1, 2, 2, 3)]
]
set1 = [[0, 0], [1, 0], [2, 0]]
Test.assert_equals(get_solutions(cards), [set1])

cards = [
  [CardExt.new(1, 1, 1, 1), CardExt.new(1, 2, 1, 2), CardExt.new(1, 1, 1, 3)],
  [CardExt.new(2, 1, 1, 1), CardExt.new(2, 2, 2, 2), CardExt.new(2, 1, 1, 3)],
  [CardExt.new(3, 1, 1, 1), CardExt.new(3, 1, 1, 2), CardExt.new(3, 1, 1, 3)],
  [CardExt.new(2, 2, 1, 1), CardExt.new(1, 2, 2, 2), CardExt.new(1, 2, 2, 3)]
]
Test.assert_equals(get_solutions(cards).length, 2)
