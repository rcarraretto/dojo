defmodule Minesweeper do

  def assemble_row(row) do
    row |> String.codepoints |> _assemble_row([])
  end

  defp _assemble_row([], acc) do
    Enum.reverse(acc)
  end

  defp _assemble_row([cell], [{prev_cell, prev_neighbors} | acc]) do
    neighbors = [prev_cell]
    t = {cell, neighbors}
    _assemble_row([], [t, {prev_cell, prev_neighbors} | acc])
  end

  defp _assemble_row([cell | cells], []) do
    neighbors = [hd(cells)]
    t = {cell, neighbors}
    _assemble_row(cells, [t])
  end

  defp _assemble_row([cell | cells], [{prev_cell, prev_neighbors} | acc]) do
    neighbors = [prev_cell, hd(cells)]
    t = {cell, neighbors}
    _assemble_row(cells, [t, {prev_cell, prev_neighbors} | acc])
  end

  def adjacent_row_neighbors(row) do
    row |> String.codepoints |> _assemble_adjacent([])
  end

  defp _assemble_adjacent([], acc) do
    Enum.reverse(acc)
  end

  # first cell
  defp _assemble_adjacent([cell | cells], []) do
    neighbors = [cell, hd(cells)]
    _assemble_adjacent(cells, [neighbors])
  end

  # last cell
  defp _assemble_adjacent([cell], acc) do
    prev_neighbors = hd(acc)
    prev_cell = List.last(prev_neighbors)
    neighbors = [prev_cell, cell]
    _assemble_adjacent([], [neighbors | acc])
  end

  # middle cell
  defp _assemble_adjacent([cell | cells], acc) do
    prev_neighbors = hd(acc)
    prev_cell_index = if length(prev_neighbors) == 2, do: 0, else: 1
    prev_cell = Enum.at(prev_neighbors, prev_cell_index)
    neighbors = [prev_cell, cell, hd(cells)]
    _assemble_adjacent(cells, [neighbors | acc])
  end

  def annotate(board) do
    board
  end
end
