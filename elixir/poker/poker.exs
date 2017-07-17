defmodule Poker do

  @category_ranks %{
    :straight_flush => 1,
    :four_of_a_kind => 2,
    :full_house => 3,
    :flush => 4,
    :straight => 5,
    :three_of_a_kind => 6,
    :two_pair => 7,
    :one_pair => 8,
    :high_card => 9,
  }

  def best_hand(hands) do
    hands
    |> Enum.map(&with_category/1)
    |> Enum.sort(&compare_categories/2)
    |> filter_bests()
    |> Enum.map(&(elem(&1, 0)))
  end

  defp with_category(hand) do
    category = categorize(hand)
    Tuple.insert_at(category, 0, hand)
  end

  defp compare_categories({_, category, values1}, {_, category, values2}) do
    compare_values(values1, values2)
  end

  defp compare_categories({_, category1, _}, {_, category2, _}) do
    @category_ranks[category1] <= @category_ranks[category2]
  end

  defp compare_values([], []) do
    true
  end

  defp compare_values([value | values1], [value | values2]) do
    compare_values(values1, values2)
  end

  defp compare_values([value1 | _], [value2 | _]) do
    value1 >= value2
  end

  defp filter_bests(categories) do
    best = hd(categories)
    categories
    |> Enum.take_while(fn(category) -> compare_categories(category, best) end)
  end

  def categorize(hand) do
    hand |> hand_to_tuples |> groups |> categorize_groups
  end

  defp hand_to_tuples(hand) do
    hand |> Enum.map(&card_to_tuple/1)
  end

  defp card_to_tuple(card) do
    [rank, suit] = Regex.run(~r/(.*)([CDHS])/, card, capture: :all_but_first)
    {rank_value(rank), suit}
  end

  defp rank_value("J"), do: 11
  defp rank_value("Q"), do: 12
  defp rank_value("K"), do: 13
  defp rank_value("A"), do: 14
  defp rank_value(rank), do: String.to_integer(rank)

  defp groups(cards) do
    cards
    |> Enum.group_by(fn({rank, _suit}) -> rank end)
    |> Enum.map(fn({_, cards}) -> {length(cards), cards} end)
    |> Enum.sort(&compare_groups/2)
  end

  defp compare_groups({length, cards1}, {length, cards2}) do
    value(cards1) >= value(cards2)
  end

  defp compare_groups({length1, _}, {length2, _}) do
    length1 >= length2
  end

  defp categorize_groups([{4, quad}, {1, kicker}]) do
    {:four_of_a_kind, values([quad, kicker])}
  end

  defp categorize_groups([{3, triplet}, {2, pair}]) do
    {:full_house, values([triplet, pair])}
  end

  defp categorize_groups([{3, triplet}, {1, high_card}, {1, low_card}]) do
    {:three_of_a_kind, values([triplet, high_card, low_card])}
  end

  defp categorize_groups([{2, high_pair}, {2, low_pair}, {1, [kicker]}]) do
    {:two_pair, values([high_pair, low_pair, kicker])}
  end

  defp categorize_groups([{2, pair} | _]) do
    {:one_pair, values([pair])}
  end

  defp categorize_groups(groups) do
    cards = groups
    |> Enum.map(fn({_, cards}) -> cards end)
    |> List.flatten

    values = values(cards)

    if is_sequence?(values) do
      categorize_sequence(cards, values)
    else
      categorize_non_sequence(cards, values)
    end
  end

  defp is_sequence?([14, 5, 4, 3, 2]) do
    true
  end

  defp is_sequence?(values) do
    sequence = List.first(values)..List.last(values) |> Enum.to_list
    values == sequence
  end

  defp categorize_sequence(cards, values) do
    category = if same_suit?(cards), do: :straight_flush, else: :straight
    {category, [highest_sequence_value(values)]}
  end

  defp highest_sequence_value(values) do
    case {List.first(values), List.last(values)} do
      {14, 2} -> 5
      {highest_value, _} -> highest_value
    end
  end

  defp categorize_non_sequence(cards, values) do
    category = if same_suit?(cards), do: :flush, else: :high_card
    {category, values}
  end

  defp same_suit?(cards) do
    cards
    |> Enum.uniq_by(fn({_, suit}) -> suit end)
    |> length() == 1
  end

  defp values(list), do: list |> Enum.map(&value/1)
  defp value([{rank, _suit} | _cards]), do: rank
  defp value({rank, _}), do: rank
end
