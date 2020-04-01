defmodule StringSeries do
  def slices(string, size) do
    string
      |> String.graphemes
      |> _slices(size)
  end

  defp _slices(_chars, size) when size <= 0, do: []
  defp _slices(chars, size) when length(chars) < size, do: []

  defp _slices(chars, size) do
    slice = Enum.take(chars, size) |> Enum.join
    [slice | _slices(tl(chars), size)]
  end
end
