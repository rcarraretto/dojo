# based on http://exercism.io/submissions/ec5a48d72ae14295a45e992370a791b2
defmodule Minesweeper do
  @bomb "*"
  @blank " "

  def annotate([]), do: []
  def annotate(board) do
    size = board |> List.first |> String.length
    board
    |> to_matrix
    |> minesweep
    |> to_board(size)
  end

  def minesweep(board) do
    for {i, row} <- board, {j, cell} <- row do
      annotate_cell(cell, board, i, j)
    end
  end

  defp annotate_cell(@bomb, _board, _i, _j) do
    @bomb
  end

  defp annotate_cell(@blank, board, i, j) do
    cell_with_neighbors(board, i, j) |> count_bombs
  end

  defp cell_with_neighbors(board, i, j) do
    for x <- -1..1, y <- -1..1, do: board[i+x][j+y]
  end

  defp count_bombs(cells) do
    count = cells |> Enum.count(&(&1 == @bomb))
    if count == 0, do: @blank, else: to_string(count)
  end

  defp to_matrix(list) do
    list
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&list_to_map/1)
    |> list_to_map
  end

  defp list_to_map(list) do
    list |> Enum.with_index |> Enum.into(%{}, fn {x, i} -> {i, x} end)
  end

  defp to_board(list, size) do
    list |> Enum.chunk(size) |> Enum.map(&to_string/1)
  end
end
