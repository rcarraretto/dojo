# Elixir v1.5.1
defmodule OCRNumbers do

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t]) :: String.t
  def convert(input) do
    num_rows = length(input)
    num_columns = input |> hd() |> String.length()
    case {rem(num_rows, 4), rem(num_columns, 3)} do
      {0, 0} -> convert_valid(input)
      {_, 0} -> {:error, 'invalid line count'}
      {0, _} -> {:error, 'invalid column count'}
    end
  end

  defp convert_valid(input) do
    number = input |> cells() |> Enum.map(&digit/1) |> Enum.join()
    {:ok, number}
  end

  defp cells(input) do
    input
    |> Enum.map(fn(row) -> row |> String.graphemes() |> Enum.chunk_every(3) end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn(cell) -> cell |> Enum.map(&Enum.join/1) end)
  end

  defp digit([
    " _ ",
    "| |",
    "|_|",
    "   "
  ]), do: "0"

  defp digit([
    "   ",
    "  |",
    "  |",
    "   "
  ]), do: "1"

  defp digit([
    " _ ",
    " _|",
    "|_ ",
    "   "
  ]), do: "2"

  defp digit([
    " _ ",
    " _|",
    " _|",
    "   "
  ]), do: "3"

  defp digit([
    "   ",
    "|_|",
    "  |",
    "   "
  ]), do: "4"

  defp digit([
    " _ ",
    "|_ ",
    " _|",
    "   "
  ]), do: "5"

  defp digit([
    " _ ",
    "|_ ",
    "|_|",
    "   "
  ]), do: "6"

  defp digit([
    " _ ",
    "  |",
    "  |",
    "   "
  ]), do: "7"

  defp digit([
    " _ ",
    "|_|",
    "|_|",
    "   "
  ]), do: "8"

  defp digit([
    " _ ",
    "|_|",
    " _|",
    "   "
  ]), do: "9"

  defp digit(_input), do: "?"
end
