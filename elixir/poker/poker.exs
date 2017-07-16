defmodule Poker do

  @category_ranks %{
    :two_pair => 7,
    :one_pair => 8,
    :high_card => 9,
  }

  def categorize(hand) do
    hand_t = hand |> init_hand
    pairs = pairs(hand_t)
    cond do
      length(pairs) == 1 -> as_one_pair(pairs)
      length(pairs) == 2 -> as_two_pair(pairs)
      true -> as_high_card(hand_t)
    end
  end

  defp pairs(hand_t) do
    hand_t
    |> Enum.group_by(fn({rank, _suit}) -> rank end)
    |> Map.values
    |> Enum.filter(fn(group) -> length(group) == 2 end)
  end

  defp as_one_pair([pair]) do
    value = pair_value(pair)
    { :one_pair, value }
  end

  defp as_two_pair(pairs) do
    values = pairs |> Enum.map(&pair_value/1) |> Enum.sort(&(&1 >= &2))
    { :two_pair, values }
  end

  defp pair_value(pair) do
    pair |> hd |> elem(0) |> rank_value
  end

  defp as_high_card(hand_t) do
    values = hand_t |> Enum.map(&to_value/1)
    { :high_card, values }
  end

  defp init_hand(hand) do
    hand
    |> hand_to_tuples
    |> Enum.sort(&compare_cards/2)
  end

  defp hand_to_tuples(hand) do
    hand |> Enum.map(&card_to_tuple/1)
  end

  defp card_to_tuple(card) do
    Regex.run(~r/(.*)([CDHS])/, card, capture: :all_but_first) |> List.to_tuple
  end

  defp compare_cards({rank1, _}, {rank2, _}) do
    rank_value(rank1) >= rank_value(rank2)
  end

  defp rank_value("J"), do: 11
  defp rank_value("Q"), do: 12
  defp rank_value("K"), do: 13
  defp rank_value("A"), do: 14
  defp rank_value(rank), do: String.to_integer(rank)

  defp to_value({rank, _}) do
    rank_value(rank)
  end

  def best_hand([hand]) do
    [hand]
  end

  @doc """
  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do
  not count as a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    hands
    |> Enum.map(&with_category/1)
    |> Enum.sort(&compare_categories/2)
    |> filter_bests
    |> Enum.map(&(elem(&1, 0)))
  end

  defp with_category(hand) do
    category = categorize(hand)
    Tuple.insert_at(category, 0, hand)
  end

  defp compare_categories({_, :two_pair, [tie, low1]}, {_, :two_pair, [tie, low2]}) do
    low1 >= low2
  end

  defp compare_categories({_, :two_pair, [high1, _]}, {_, :two_pair, [high2, _]}) do
    high1 >= high2
  end

  defp compare_categories({_, :one_pair, value1}, {_, :one_pair, value2}) do
    value1 >= value2
  end

  defp compare_categories({_, :high_card, values1}, {_, :high_card, values2}) do
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
end
