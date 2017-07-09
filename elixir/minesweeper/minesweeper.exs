defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []
  def annotate(board) do
    size = board |> List.first |> String.length
    board
    |> _to_matrix
    |> minesweep
    |> _to_board(size)
  end
  def minesweep(board) do
    for {i, row} <- board, {j, c} <- row do
      if c == " " do
        (for x <- -1..1, y <- -1..1, do: board[i+x][j+y])
        |> Enum.count(& &1 == "*")
        |> _convert
      else
        c
      end
    end
  end
  defp _to_matrix(list), do: list |> Enum.map(&String.graphemes/1) |> Enum.map(&_to_map/1) |> _to_map
  defp _to_map(list), do: list |> Enum.with_index |> Enum.into(%{}, fn {x, i} -> {i, x} end)
  defp _convert(0), do: " "
  defp _convert(n), do: to_string(n)
  defp _to_board(list, size), do: list |> Enum.chunk(size) |> Enum.map(&to_string/1)
end
