defmodule Poker do

  def categorize(hand) do
    high = hand
    |> hand_to_tuples
    |> Enum.sort(&compare_cards/2)
    |> List.last
    |> elem(0)
    { :high_card, high }
  end

  defp hand_to_tuples(hand) do
    hand |> Enum.map(&card_to_tuple/1)
  end

  defp card_to_tuple(card) do
    Regex.run(~r/(.*)([CDHS])/, card, capture: :all_but_first) |> List.to_tuple
  end

  defp compare_cards({rank1, _}, {rank2, _}) do
    rank_value(rank1) < rank_value(rank2)
  end

  defp rank_value("J"), do: 11
  defp rank_value("Q"), do: 12
  defp rank_value("K"), do: 13
  defp rank_value("A"), do: 14
  defp rank_value(rank), do: String.to_integer(rank)

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

  defp compare_categories({_, _, high_card}, {_, _, high_card2}) do
    rank_value(high_card) >= rank_value(high_card2)
  end

  defp filter_bests(categories) do
    {_, _, best_high_card } = hd(categories)
    categories
    |> Enum.filter(fn({_, _, high_card}) -> high_card == best_high_card end)
  end
end
