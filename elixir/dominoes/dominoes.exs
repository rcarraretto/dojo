defmodule Dominoes do

  def chain?([]) do
    true
  end

  def chain?([stone | stones]) do
    step([stone], stones)
  end

  defp step(placed, []) do
    {l1, _} = List.last(placed)
    {_, r2} = hd(placed)
    l1 == r2
  end

  defp step(placed, stock) do
    stone1 = hd(placed)
    Enum.any?(stock, fn(stone2) ->
      case {stone1, stone2} do
        {{_, x}, {x, y}} -> step([{x, y} | placed], List.delete(stock, stone2))
        {{_, x}, {y, x}} -> step([{x, y} | placed], List.delete(stock, stone2))
        _                -> false
      end
    end)
  end
end
