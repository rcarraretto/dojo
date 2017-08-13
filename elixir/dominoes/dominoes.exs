defmodule Dominoes do

  def chain?([]) do
    true
  end

  def chain?([stone | stones]) do
    step({stone, stone}, stones)
  end

  defp step({{x, _}, {_, x}}, []) do
    true
  end

  defp step(_, []) do
    false
  end

  defp step({first_stone, last_stone}, stock) do
    Enum.any?(stock, fn(stone) ->
      case {last_stone, stone} do
        {{_, x}, {x, y}} -> step({first_stone, {x, y}}, List.delete(stock, stone))
        {{_, x}, {y, x}} -> step({first_stone, {x, y}}, List.delete(stock, stone))
        _                -> false
      end
    end)
  end
end
