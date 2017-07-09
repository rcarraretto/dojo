# based on http://exercism.io/submissions/ec5a48d72ae14295a45e992370a791b2
defmodule Minesweeper do
  @bomb "*"
  @blank " "

  def annotate(board) do
    board
    |> to_matrix()
    |> annotate_matrix()
    |> to_board()
  end

  defp annotate_matrix(matrix) do
    for {i, row} <- matrix do
      annotate_row(matrix, i, row)
    end
  end

  defp annotate_row(matrix, i, row) do
    cells = for {j, cell} <- row do
      annotate_cell(matrix, i, j, cell)
    end
    {i, cells}
  end

  defp annotate_cell(_matrix, _i, _j, @bomb) do
    @bomb
  end

  defp annotate_cell(matrix, i, j, @blank) do
    cell_with_neighbors(matrix, i, j) |> count_bombs()
  end

  defp cell_with_neighbors(matrix, i, j) do
    for x <- -1..1, y <- -1..1, do: matrix[i+x][j+y]
  end

  defp count_bombs(cells) do
    count = cells |> Enum.count(&(&1 == @bomb))
    if count == 0, do: @blank, else: to_string(count)
  end

  defp to_matrix(list) do
    list
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&list_to_map/1)
    |> list_to_map()
  end

  defp list_to_map(list) do
    list |> Enum.with_index() |> Enum.into(%{}, fn {x, i} -> {i, x} end)
  end

  defp to_board(matrix) do
    matrix |> Enum.map(fn({_i, row}) -> row end) |> Enum.map(&to_string/1)
  end
end
