defmodule Minesweeper do

  def annotate(board) do
    board
    |> Enum.map(&String.codepoints/1)
    |> annotate_rows
    |> Enum.map(&Enum.join/1)
  end

  defp annotate_rows(rows) do
    rows
    |> Rows.with_adjacents
    |> Enum.map(&annotate_row/1)
  end

  defp annotate_row({row, adjacent_rows}) do
    neighbors = Neighbors.all({row, adjacent_rows})
    [row, neighbors]
    |> List.zip()
    |> Enum.map(&annotate_cell/1)
  end

  defp annotate_cell({ "*", _neighbors }) do
    "*"
  end

  defp annotate_cell({ " ", neighbors }) do
    count = Enum.count(neighbors, fn(cell) -> cell == "*" end)
    if count == 0, do: " ", else: count
  end
end

defmodule Rows do

  def with_adjacents(rows) do
    _with_adjacents(rows, [])
  end

  defp _with_adjacents([], acc) do
    Enum.reverse(acc)
  end

  # first and only row
  defp _with_adjacents([row], []) do
    row_t = { row, [] }
    _with_adjacents([], [row_t])
  end

  # first row
  defp _with_adjacents([row | rows], []) do
    row_t = {row, [hd(rows)]}
    _with_adjacents(rows, [row_t])
  end

  # last row
  defp _with_adjacents([row], acc) do
    row_above = elem(hd(acc), 0)
    row_t = {row, [row_above]}
    _with_adjacents([], [row_t | acc])
  end

  # middle row
  defp _with_adjacents([row, row_below | rows], acc) do
    row_above = elem(hd(acc), 0)
    row_t = {row, [row_above, row_below]}
    _with_adjacents([row_below | rows], [row_t | acc])
  end
end

defmodule Neighbors do

  def all({row, adjacent_rows}) do
    [horizontal(row) | verticals(adjacent_rows)]
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&List.flatten/1)
  end


  defp horizontal(row) do
    row
    |> _horizontal([])
    |> Enum.map(fn({ _cell, neighbors }) -> neighbors end)
  end

  defp _horizontal([], acc) do
    Enum.reverse(acc)
  end

  defp _horizontal([cell], [{prev_cell, prev_neighbors} | acc]) do
    neighbors = [prev_cell]
    t = {cell, neighbors}
    _horizontal([], [t, {prev_cell, prev_neighbors} | acc])
  end

  defp _horizontal([cell | cells], []) do
    neighbors = if Enum.empty?(cells), do: [], else: [hd(cells)]
    t = {cell, neighbors}
    _horizontal(cells, [t])
  end

  defp _horizontal([cell | cells], [{prev_cell, prev_neighbors} | acc]) do
    neighbors = [prev_cell, hd(cells)]
    t = {cell, neighbors}
    _horizontal(cells, [t, {prev_cell, prev_neighbors} | acc])
  end


  defp verticals(rows) do
    Enum.map(rows, &vertical/1)
  end

  defp vertical(row) do
    row |> _vertical([])
  end

  defp _vertical([], acc) do
    Enum.reverse(acc)
  end

  # first cell
  defp _vertical([cell | cells], []) do
    neighbors = if Enum.empty?(cells), do: [cell], else: [cell, hd(cells)]
    _vertical(cells, [neighbors])
  end

  # last cell
  defp _vertical([cell], acc) do
    prev_neighbors = hd(acc)
    prev_cell = List.last(prev_neighbors)
    neighbors = [prev_cell, cell]
    _vertical([], [neighbors | acc])
  end

  # middle cell
  defp _vertical([cell | cells], acc) do
    prev_neighbors = hd(acc)
    prev_cell_index = if length(prev_neighbors) == 2, do: 0, else: 1
    prev_cell = Enum.at(prev_neighbors, prev_cell_index)
    neighbors = [prev_cell, cell, hd(cells)]
    _vertical(cells, [neighbors | acc])
  end
end
