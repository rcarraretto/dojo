defmodule Acronym do
  def abbreviate(string) do
    string
      |> alpha_only
      |> String.split
      |> Enum.map(&word_to_acronym/1)
      |> Enum.join
  end

  def alpha_only(string) do
    string |> String.replace(~r/[^[:alpha:]\s]/u, "")
  end

  def word_to_acronym(word) do
    case get_upcase_chars(word) do
      [] -> word |> String.first |> String.upcase
      upcase_chars -> upcase_chars
    end
  end

  def get_upcase_chars(word) do
    Regex.scan(~r/\p{Lu}/u, word)
  end
end
