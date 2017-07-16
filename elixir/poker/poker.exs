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

  def best_hand([hand]) do
    [hand]
  end

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

  defp groups(hand_t) do
    hand_t
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
    sorted_hand = groups
    |> Enum.map(fn({_, cards}) -> cards end)
    |> List.flatten
    sorted_values = sorted_hand |> Enum.map(&value/1) |> Enum.reverse
    is_same_suit = same_suit?(sorted_hand)
    is_sequence = is_sequence?(sorted_values)
    cond do
      is_same_suit and is_sequence -> as_straight(:straight_flush, sorted_values)
      is_same_suit -> {:flush, sorted_values |> Enum.reverse}
      is_sequence -> as_straight(:straight, sorted_values)
      true -> {:high_card, sorted_values |> Enum.reverse}
    end
  end

  defp same_suit?(hand_t) do
    hand_t
    |> Enum.group_by(fn({_, suit}) -> suit end)
    |> Map.keys()
    |> length() == 1
  end

  defp is_sequence?(sorted_values) do
    sequences = sequences(sorted_values)
    Enum.any?(sequences, &(&1 == sorted_values))
  end

  defp sequences([low, _, _, penultimate, 14]) do
    start_with_ace = low..penultimate |> Enum.to_list |> List.insert_at(-1, 14)
    end_with_ace = low..14 |> Enum.to_list
    [start_with_ace, end_with_ace]
  end

  defp sequences(sorted_values) do
    sequence = Enum.at(sorted_values, 0)..Enum.at(sorted_values, 4) |> Enum.to_list
    [sequence]
  end

  def as_straight(category, sorted_values) do
    high = case List.last(sorted_values) do
      14 -> if List.first(sorted_values) == 2, do: 5, else: 14
      high -> high
    end
    {category, [high]}
  end

  defp values(list), do: list |> Enum.map(&value/1)
  defp value([{rank, _suit} | _cards]), do: rank
  defp value({rank, _}), do: rank
end
