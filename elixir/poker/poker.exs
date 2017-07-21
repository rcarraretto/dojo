defmodule Poker do

  def best_hand(hands) do
    hands
    |> Enum.map(&with_score/1)
    |> Enum.sort(&compare_categories/2)
    |> filter_bests()
  end

  defp with_score(hand) do
    {category, values} = categorize(hand)
    score = [category_rank(category), values]
    {hand, score}
  end

  defp compare_categories({_, score1}, {_, score2}) do
    score1 >= score2
  end

  defp category_rank(:straight_flush), do: 9
  defp category_rank(:four_of_a_kind), do: 8
  defp category_rank(:full_house), do: 7
  defp category_rank(:flush), do: 6
  defp category_rank(:straight), do: 5
  defp category_rank(:three_of_a_kind), do: 4
  defp category_rank(:two_pair), do: 3
  defp category_rank(:one_pair), do: 2
  defp category_rank(:high_card), do: 1

  defp filter_bests(categories) do
    best = hd(categories)
    categories
    |> Enum.take_while(fn(category) -> compare_categories(category, best) end)
    |> Enum.map(&(elem(&1, 0)))
  end

  def categorize(hand) do
    hand |> hand_to_tuples() |> group_by_rank() |> categorize_groups()
  end

  defp hand_to_tuples(hand) do
    hand |> Enum.map(&card_to_tuple/1)
  end

  defp card_to_tuple(card) do
    {rank, suit} = String.split_at(card, -1)
    {rank_value(rank), suit}
  end

  defp rank_value("A"), do: 14
  defp rank_value("K"), do: 13
  defp rank_value("Q"), do: 12
  defp rank_value("J"), do: 11
  defp rank_value(rank), do: String.to_integer(rank)

  defp group_by_rank(cards) do
    cards
    |> Enum.group_by(fn({rank, _suit}) -> rank end)
    |> Enum.map(fn({_rank, cards}) -> {length(cards), cards} end)
    |> Enum.sort(&>=/2)
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

  defp categorize_groups([{2, high_pair}, {2, low_pair}, {1, kicker}]) do
    {:two_pair, values([high_pair, low_pair, kicker])}
  end

  defp categorize_groups([{2, pair} | _]) do
    {:one_pair, values([pair])}
  end

  defp categorize_groups(cards_by_rank) do
    cards = cards_by_rank
    |> Enum.map(fn({_rank, cards}) -> cards end)
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
    |> Enum.uniq_by(fn({_rank, suit}) -> suit end)
    |> length() == 1
  end

  defp values(list), do: list |> Enum.map(&value/1)

  defp value([{rank, _suit} | _cards]), do: rank
  defp value({rank, _suit}), do: rank
end
