defmodule Minesweeper do

  def annotate(board) do
    board
    |> BoardMatrix.init
    |> annotate_matrix
    |> BoardMatrix.to_board
  end

  defp annotate_matrix(matrix) do
    matrix
    |> scan_diagonal
  end

  defp scan_diagonal(matrix) do
    matrix
    |> triples([])
    |> Enum.map(&scan_triple/1)
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

  # given a triple, iterate over the main row cells
  # for each cell, get it's neighbors
  def scan_triple([row]) do
    # IO.inspect row
    row |> scan_right([])
  end

  defp scan_right([], acc) do
    Enum.reverse(acc)
  end

  defp scan_right([x], acc) do
    scan_right([], [x | acc])
  end

  defp scan_right(["*", 0], acc) do
    scan_right([], [1, "*" | acc])
  end

  defp scan_right(["*", 0, "*" | tail], acc) do
    scan_right(["*" | tail], [2, "*" | acc])
  end

  defp scan_right([0, "*" | tail], acc) do
    scan_right(["*" | tail], [1 | acc])
  end

  defp scan_right([x, y | tail], acc) do
    scan_right(tail, [y, x | acc])
  end

  defp transpose(matrix) do
    List.zip(matrix) |> Enum.map(&Tuple.to_list/1)
  end
end

defmodule BoardMatrix do

  def init(board) do
    board |> Enum.map(&init_row/1)
  end

  defp init_row(row) do
    row |> String.codepoints |> Enum.map(&init_cell/1)
  end

  defp init_cell(cell) do
    case cell == " " do
      true -> 0
      false -> cell
    end
  end

  def to_board(matrix) do
    matrix |> Enum.map(&to_board_row/1)
  end

  defp to_board_row(row) do
    row |> Enum.map(&to_board_cell/1) |> Enum.join
  end

  defp to_board_cell(cell) do
    cond do
      cell == 0 -> " "
      is_integer(cell) -> Integer.to_string(cell)
      true -> cell
    end
  end
end
