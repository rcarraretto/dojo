defmodule Minesweeper do

  def annotate(board) do
    board
    |> Enum.map(&String.codepoints/1)
    |> triples([])
    |> Enum.map(&annotate_row/1)
    |> Enum.map(&Enum.join/1)
  end

  def annotate_row([row]) do
    neighbors = same_row_neighbors(row)
    base_annotate(row, neighbors)
  end

  def annotate_row([row, row_below]) do
    neighbors1 = same_row_neighbors(row)
    neighbors2 = adjacent_row_neighbors(row_below)
    neighbors = all_neighbors([neighbors1, neighbors2])
    base_annotate(row, neighbors)
  end

  def annotate_row([row, row_above, row_below]) do
    neighbors1 = same_row_neighbors(row)
    neighbors2 = adjacent_row_neighbors(row_above)
    neighbors3 = adjacent_row_neighbors(row_below)
    neighbors = all_neighbors([neighbors1, neighbors2, neighbors3])
    base_annotate(row, neighbors)
  end

  defp all_neighbors(list) do
    list |> List.zip |> Enum.map(&Tuple.to_list/1) |> Enum.map(&List.flatten/1)
  end

  defp base_annotate(row, neighbors) do
    cells = List.zip([row, neighbors])
    cells
    |> Enum.map(&annotate_cell/1)
  end

  defp annotate_cell({ "*", _neighbors }) do
    "*"
  end

  defp annotate_cell({ " ", neighbors }) do
    count = Enum.count(neighbors, fn(cell) -> cell == "*" end)
    if count == 0, do: " ", else: count
  end

  defp triples([], acc) do
    Enum.reverse(acc)
  end

  # first and only row
  defp triples([row], []) do
    triple = [row]
    triples([], [triple])
  end

  # first row
  defp triples([row | rows], []) do
    triple = [row, hd(rows)]
    triples(rows, [triple])
  end

  # last row
  defp triples([row], acc) do
    row_above = hd(hd(acc))
    triple = [row, row_above]
    triples([], [triple | acc])
  end

  # middle row
  defp triples([row, row_below | rows], acc) do
    row_above = hd(hd(acc))
    triple = [row, row_above, row_below]
    triples([row_below | rows], [triple | acc])
  end


  def same_row_neighbors(row) do
    row |> _assemble_row([])
    |> Enum.map(fn({ _cell, neighbors }) -> neighbors end)
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
    neighbors = if Enum.empty?(cells), do: [], else: [hd(cells)]
    t = {cell, neighbors}
    _assemble_row(cells, [t])
  end

  defp _assemble_row([cell | cells], [{prev_cell, prev_neighbors} | acc]) do
    neighbors = [prev_cell, hd(cells)]
    t = {cell, neighbors}
    _assemble_row(cells, [t, {prev_cell, prev_neighbors} | acc])
  end

  def adjacent_row_neighbors(row) do
    row |> _assemble_adjacent([])
  end

  defp _assemble_adjacent([], acc) do
    Enum.reverse(acc)
  end

  # first cell
  defp _assemble_adjacent([cell | cells], []) do
    neighbors = if Enum.empty?(cells), do: [cell], else: [cell, hd(cells)]
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
end
