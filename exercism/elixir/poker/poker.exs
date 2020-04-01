defmodule Card do
  defstruct [:rank, :suit]

  def new(str) do
    {rank, suit} = String.split_at(str, -1)
    %Card{rank: rank_value(rank), suit: suit}
  end

  defp rank_value("A"),  do: 14
  defp rank_value("K"),  do: 13
  defp rank_value("Q"),  do: 12
  defp rank_value("J"),  do: 11
  defp rank_value(rank), do: String.to_integer(rank)
end

defmodule CardGroups do

  def categorize(cards) do
    groups = group_by_rank(cards)
    {categorize_groups(groups), values(groups)}
  end

  defp group_by_rank(cards) do
    cards
    |> Enum.group_by(&(&1.rank))
    |> Enum.map(fn({_rank, cards}) -> {length(cards), cards} end)
    |> Enum.sort(&>=/2)
  end

  defp categorize_groups(groups) do
    lengths = Enum.map(groups, &(elem(&1, 0)))
    case lengths do
      [4, 1]       -> :four_of_a_kind
      [3, 2]       -> :full_house
      [3, 1, 1]    -> :three_of_a_kind
      [2, 2, 1]    -> :two_pair
      [2, 1, 1, 1] -> :one_pair
      _            -> :distinct
    end
  end

  defp values(groups) do
    cards_by_group = Enum.map(groups, &(elem(&1, 1)))
    Enum.map(cards_by_group, &(group_value(&1)))
  end

  defp group_value([card | _cards]), do: card.rank
end

defmodule DistinctCards do
  defstruct [:straight, :flush, :values]

  @five_high_straight [14, 5, 4, 3, 2]

  def categorize(cards, values) do
    distinct = %DistinctCards{
      straight: straight?(values),
      flush: flush?(cards),
      values: values
    }
    {_categorize(distinct), _values(distinct, values)}
  end

  defp straight?(@five_high_straight) do
    true
  end

  defp straight?(values) do
    sequence = List.first(values)..List.last(values) |> Enum.to_list
    values == sequence
  end

  defp flush?(cards) do
    cards |> Enum.uniq_by(&(&1.suit)) |> length() == 1
  end

  defp _categorize(%DistinctCards{straight: true, flush: true}), do: :straight_flush
  defp _categorize(%DistinctCards{straight: true}),              do: :straight
  defp _categorize(%DistinctCards{flush: true}),                 do: :flush
  defp _categorize(_),                                           do: :high_card

  defp _values(_, @five_high_straight),                 do: 5
  defp _values(%DistinctCards{straight: true}, values), do: List.first(values)
  defp _values(_, values),                              do: values
end

defmodule HandCategory do

  def for(hand) do
    cards = Enum.map(hand, &Card.new/1)
    categorization = CardGroups.categorize(cards)
    case categorization do
      {:distinct, values} -> DistinctCards.categorize(cards, values)
      _                   -> categorization
    end
  end
end

defmodule HandWithScore do
  defstruct cards: [], score: 0

  def new(cards) do
    {category, values} = HandCategory.for(cards)
    score = [category_rank(category), values]
    %HandWithScore{cards: cards, score: score}
  end

  defp category_rank(:straight_flush),  do: 9
  defp category_rank(:four_of_a_kind),  do: 8
  defp category_rank(:full_house),      do: 7
  defp category_rank(:flush),           do: 6
  defp category_rank(:straight),        do: 5
  defp category_rank(:three_of_a_kind), do: 4
  defp category_rank(:two_pair),        do: 3
  defp category_rank(:one_pair),        do: 2
  defp category_rank(:high_card),       do: 1
end

defmodule Poker do

  def best_hand(hands) do
    hands
    |> Enum.map(&HandWithScore.new/1)
    |> Enum.sort_by(&(&1.score), &>=/2)
    |> Enum.chunk_by(&(&1.score))
    |> List.first()
    |> Enum.map(&(&1.cards))
  end
end
