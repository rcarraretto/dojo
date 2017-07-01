defmodule RunLengthEncoder do
  def encode(string) do
    string
      |> String.graphemes
      |> encode_chars
      |> Enum.join
  end

  defp encode_chars([]) do
    []
  end

  defp encode_chars([char | tail]) do
    rest = Enum.drop_while(tail, fn(other) -> other == char end)
    case length(tail) - length(rest) do
      0 -> [char | encode_chars(rest)]
      additional_drops -> [additional_drops + 1, char | encode_chars(rest)]
    end
  end

  def decode(string) do
    string
      |> String.graphemes
      |> decode_chars
      |> Enum.join
  end

  defp decode_chars([]), do: []

  defp decode_chars(chars) do
    numbers = Enum.take_while(chars, fn(c) -> c =~ ~r/[0-9]/ end)
    rest = chars -- numbers
    case length(numbers) do
      0 -> [hd(chars) | decode_chars(tl(chars))]
      _ -> [String.duplicate(hd(rest), String.to_integer(numbers |> Enum.join))] ++
        decode_chars(tl(rest))
    end
  end
end
