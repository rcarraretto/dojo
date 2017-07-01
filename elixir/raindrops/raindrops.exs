defmodule Raindrops do
  def convert(number) do
    case noise(number) do
      "" -> to_string(number)
      noise -> noise
    end
  end

  defp noise(number) do
    number
      |> factors
      |> Enum.map(&factor_noise/1)
      |> Enum.join
  end

  defp factors(number) do
    [3, 5, 7] |> Enum.map(&({rem(number, &1), &1}))
  end

  defp factor_noise({0, 3}), do: "Pling"
  defp factor_noise({0, 5}), do: "Plang"
  defp factor_noise({0, 7}), do: "Plong"
  defp factor_noise({_rem, _factor}), do: ""
end
