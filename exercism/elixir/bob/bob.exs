defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    input |> String.trim |> String.length == 0
  end

  defp question?(input) do
    String.last(input) == "?"
  end

  defp shouting?(input) do
    phrase = alpha(input)
    case phrase do
      "" -> false
      _ -> phrase == phrase |> String.upcase
    end
  end

  defp alpha(input) do
    input |> String.replace(~r/[^[:alpha:]]/, "")
  end
end
