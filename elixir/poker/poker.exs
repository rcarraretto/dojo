defmodule Poker do

  def best_hand(hands) do
    hands
    |> Enum.map(&with_score/1)
    |> Enum.sort_by(&(elem(&1, 1)), &>=/2)
    |> Enum.chunk_by(&(elem(&1, 1)))
    |> List.first()
    |> Enum.map(&(elem(&1, 0)))
  end

  defp with_score(hand) do
    {category, values} = HandCategory.for(hand)
    score = [category_rank(category), values]
    {hand, score}
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
end

defmodule HandCategory do

  def for(hand) do
    cards = hand_to_tuples(hand)
    groups = group_by_rank(cards)
    category = categorize_groups(cards, groups)
    values = category_values(category, cards, groups)
    {category, values}
  end

  defp hand_to_tuples(hand) do
    hand |> Enum.map(&card_to_tuple/1) |> Enum.sort(&>=/2)
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

  defp categorize_groups(cards, groups) do
    case Enum.map(groups, &(elem(&1, 0))) do
      [4, 1] -> :four_of_a_kind
      [3, 2] -> :full_house
      [3, 1, 1] -> :three_of_a_kind
      [2, 2, 1] -> :two_pair
      [2, 1, 1, 1] -> :one_pair
      _ -> categorize_distinct(cards)
    end
  end

  defp categorize_distinct(cards) do
    values = values(cards)
    case [is_sequence?(values), same_suit?(cards)] do
      [true, true] -> :straight_flush
      [true, false] -> :straight
      [false, true] -> :flush
      _ -> :high_card
    end
  end

  defp is_sequence?([14, 5, 4, 3, 2]) do
    true
  end

  defp is_sequence?(values) do
    sequence = List.first(values)..List.last(values) |> Enum.to_list
    values == sequence
  end

  defp same_suit?(cards) do
    cards
    |> Enum.uniq_by(fn({_rank, suit}) -> suit end)
    |> length() == 1
  end

  defp category_values(:straight, cards, _) do
    highest_sequence_value(cards)
  end

  defp category_values(:straight_flush, cards, _) do
    highest_sequence_value(cards)
  end

  defp category_values(_, _, groups) do
    cards_by_group = Enum.map(groups, &(elem(&1, 1)))
    Enum.map(cards_by_group, &(value(&1)))
  end

  defp highest_sequence_value(cards) do
    values = values(cards)
    case {List.first(values), List.last(values)} do
      {14, 2} -> 5
      {highest_value, _} -> highest_value
    end
  end

  defp values(list), do: list |> Enum.map(&value/1)

  defp value([{rank, _suit} | _cards]), do: rank
  defp value({rank, _suit}), do: rank
end
