defmodule Scrabble do

  @char_groups [
    { ~w[A E I O U L N R S T], 1 },
    { ~w[D G], 2 },
    { ~w[B C M P], 3 },
    { ~w[F H V W Y], 4 },
    { ~w[K], 5 },
    { ~w[J X], 8 },
    { ~w[Q Z], 10 },
  ]

  def score(word) do
    word
      |> String.replace(~r/[^A-Za-z]/, "")
      |> String.upcase
      |> String.codepoints
      |> Enum.map(&to_score/1)
      |> Enum.sum
  end

  defp to_score(char) do
    case char_group(char) do
      { _, score } -> score
      _ -> raise "Could not find score for char: #{char}"
    end
  end

  defp char_group(char) do
    @char_groups
      |> Enum.find(fn({ char_group, _ }) -> Enum.member?(char_group, char) end)
  end
end
