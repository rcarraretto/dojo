defmodule Dominoes do

  def chain?([]) do
    true
  end

  def chain?([stone | stones]) do
    step([stone], stones)
  end

  defp step(placed, []) do
    result = Enum.reverse(placed)
    {l1, _} = hd(result)
    {_, r2} = List.last(result)
    l1 == r2
  end

  defp step(placed, stock) do
    {_, r1} = hd(placed)
    Enum.any?(stock, fn(stone2) ->
      {l2, r2} = stone2
      case {r1 == l2, r1 == r2} do
        {true, _} -> step([{l2, r2} | placed], List.delete(stock, stone2))
        {_, true} -> step([{r2, l2} | placed], List.delete(stock, stone2))
        _         -> false
      end
    end)
  end
end
