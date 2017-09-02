# Elixir v1.5.1
defmodule OCRNumbers do
  @rows 4
  @cols 3

  def convert(input) do
    {num_rows, num_cols} = dimensions(input)
    case {rem(num_rows, @rows), rem(num_cols, @cols)} do
      {0, 0} -> {:ok, convert_valid(input)}
      {_, 0} -> {:error, 'invalid line count'}
      {0, _} -> {:error, 'invalid column count'}
    end
  end

  defp dimensions(input) do
    num_rows = length(input)
    num_cols = input |> hd() |> String.length()
    {num_rows, num_cols}
  end

  defp convert_valid(input) do
    input
    |> cells_per_line()
    |> Enum.map(&convert_line/1)
    |> Enum.join(",")
  end

  defp cells_per_line(input) do
    input
    |> Enum.chunk_every(@rows)
    |> Enum.map(&cells_in_line/1)
  end

  defp cells_in_line(font_line) do
    font_line
    |> Enum.map(&chunk_font_row/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp chunk_font_row(row) do
    row |> String.graphemes() |> Enum.chunk_every(@cols) |> Enum.map(&Enum.join/1)
  end

  defp convert_line(cells) do
    cells |> Enum.map(&convert_digit/1) |> Enum.join()
  end

  defp convert_digit([
    " _ ",
    "| |",
    "|_|",
    "   "
  ]), do: "0"

  defp convert_digit([
    "   ",
    "  |",
    "  |",
    "   "
  ]), do: "1"

  defp convert_digit([
    " _ ",
    " _|",
    "|_ ",
    "   "
  ]), do: "2"

  defp convert_digit([
    " _ ",
    " _|",
    " _|",
    "   "
  ]), do: "3"

  defp convert_digit([
    "   ",
    "|_|",
    "  |",
    "   "
  ]), do: "4"

  defp convert_digit([
    " _ ",
    "|_ ",
    " _|",
    "   "
  ]), do: "5"

  defp convert_digit([
    " _ ",
    "|_ ",
    "|_|",
    "   "
  ]), do: "6"

  defp convert_digit([
    " _ ",
    "  |",
    "  |",
    "   "
  ]), do: "7"

  defp convert_digit([
    " _ ",
    "|_|",
    "|_|",
    "   "
  ]), do: "8"

  defp convert_digit([
    " _ ",
    "|_|",
    " _|",
    "   "
  ]), do: "9"

  defp convert_digit(_cell), do: "?"
end
