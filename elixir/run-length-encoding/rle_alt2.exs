defmodule RunLengthEncoder do
  def encode(string) do
    string
      |> String.graphemes
      |> encode_chars({[], []})
      |> Enum.join
  end

  defp encode_chars([], {encoded, _}), do: Enum.reverse(encoded)

  defp encode_chars([a], {encoded, waiting}) do
    encode_chars([], {compress(a, waiting) ++ encoded, []})
  end

  defp encode_chars([a | tail], {encoded, waiting}) do
    case a == hd(tail) do
      true -> encode_chars(tail, {encoded, [a | waiting]})
      _ -> encode_chars(tail, {compress(a, waiting) ++ encoded, []})
    end
  end

  def compress(c, []), do: [c]
  def compress(c, other_cs) do
    count = length(other_cs) + 1 |> to_string |> String.graphemes |> Enum.reverse
    [c | count]
  end

  def decode(string) do
    string
      |> String.graphemes
      |> decode_chars({[], []})
      |> Enum.join
  end

  defp decode_chars([], {decoded, _}), do: Enum.reverse(decoded)

  defp decode_chars([c | tail], {decoded, numbers}) do
    case c =~ ~r/[0-9]/ do
      true -> decode_chars(tail, {decoded, [c | numbers]})
      _ -> decode_chars(tail, {decompress(c, numbers) ++ decoded, []})
    end
  end

  defp decompress(c, []), do: [c]
  defp decompress(c, numbers) do
    times = numbers |> Enum.reverse |> Enum.join |> String.to_integer
    String.duplicate(c, times) |> String.graphemes
  end
end
