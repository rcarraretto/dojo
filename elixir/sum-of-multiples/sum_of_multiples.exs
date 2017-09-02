defmodule SumOfMultiples do

  def to(limit, factors) do
    factors
    |> Enum.map(&(multiples(&1, limit)))
    |> List.flatten()
    |> Enum.sort()
    |> Enum.dedup()
    |> Enum.sum()
  end

  defp multiples(num, limit), do: _multiples(num, limit, [0])

  defp _multiples(num, limit, multiples = [current | _]) do
    next = current + num
    if next < limit do
      _multiples(num, limit, [next | multiples])
    else
      multiples
    end
  end
end
