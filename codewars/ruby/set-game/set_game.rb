def get_solutions(game)
  sets = valid_sets(game)
  solution = valid_solution(sets)
  solution.to_index(game)
end

def valid_sets(game)
  game.flatten
    .combination(3)
    .map { |three_cards| CardSet.new(three_cards) }
    .select { |set| set.valid? }
    .to_a
end

def valid_solution(sets)
  set_combinations = (1..sets.length)
    .flat_map { |n| sets.combination(n).to_a }
  set_combinations
    .map { |sets| Solution.new(sets) }
    .select { |solution| solution.valid? }
    .max_by { |solution| solution.length }
end

class CardSet
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def valid?
    values_by_type.all? { |values| values_match?(values) }
  end

  def values_by_type
    @cards.map(&:to_a).transpose
  end

  def values_match?(values)
    u = values.uniq
    u.length == 1 || u.length == 3
  end

  def to_index(game)
    @cards.map { |card| index(card, game) }
  end

  def index(card, game)
    row = game.detect { |row| row.include?(card) }
    row_index = game.index(row)
    col_index = row.index(card)
    [row_index, col_index]
  end
end

class Solution
  def initialize(sets)
    @sets = sets
  end

  def valid?
    cards = @sets.flat_map { |set| set.cards }
    cards.length == cards.uniq.length
  end

  def to_index(game)
    @sets.map { |set| set.to_index(game) }
  end

  def length
    @sets.length
  end
end
