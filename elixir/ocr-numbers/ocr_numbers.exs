defmodule OCRNumbers do

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t]) :: String.t
  def convert(input) do
    num_rows = length(input)
    num_columns = input |> hd() |> String.length()
    case {num_rows, num_columns} do
      {4, 3} -> {:ok, digit(input)}
      {_, 3} -> {:error, 'invalid line count'}
      {4, _} -> {:error, 'invalid column count'}
    end
  end

  def digit([
    " _ ",
    "| |",
    "|_|",
    "   "
  ]), do: "0"

  def digit([
    "   ",
    "  |",
    "  |",
    "   "
  ]), do: "1"

  def digit(_input), do: "?"
end
