defmodule Words do
  def count(sentence) do
    sentence
      |> normalize
      |> String.split
      |> Enum.reduce(%{}, &add_word/2)
  end

  defp normalize(sentence) do
    sentence
      |> String.replace(~r/[^[:alnum:]\s-]/u, " ")
      |> String.downcase
  end

  def add_word(word, acc) do
    Map.update(acc, word, 1, &(&1 + 1))
  end
end
