defmodule SumOfMultiples do

  def to(limit, factors) do
    1..limit - 1
    |> Enum.filter(fn(x) ->
      Enum.any?(factors, fn(factor) -> rem(x, factor) == 0 end)
    end)
    |> Enum.uniq()
    |> Enum.sum()
  end
end
