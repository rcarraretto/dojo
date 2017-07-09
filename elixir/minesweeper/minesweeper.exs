defmodule Minesweeper do

  def annotate(board) do
    board |> triples([]) |> Enum.map(&annotate_row/1)
  end

  defp annotate_row([row]) do
    neighbors = same_row_neighbors(row)
    List.zip([row |> String.codepoints, neighbors])
    |> Enum.map(&annotate_cell/1)
    |> Enum.join
  end

  defp annotate_cell({ "*", _neighbors }) do
    "*"
  end

  defp annotate_cell({ " ", neighbors }) do
    Enum.count(neighbors, fn(cell) -> cell == "*" end)
  end

  defp triples([], acc) do
    Enum.reverse(acc)
  end

  defp triples([row], acc) do
    triple = [row]
    triples([], [triple | acc])
  end

  defp triples([row1, row2], acc) do
    triple = [row1, row2]
    triples([row2], [triple | acc])
  end

  defp triples([row1, row2, row3 | rows], acc) do
    triple = [row1, row2, row3]
    triples([row2, row3 | rows], [triple | acc])
  end


  def same_row_neighbors(row) do
    row |> String.codepoints |> _assemble_row([])
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

end
