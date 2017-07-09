defmodule Minesweeper do

  def annotate(board) do
    board
    |> BoardMatrix.init
    |> annotate_matrix
    |> BoardMatrix.to_board
  end

  defp annotate_matrix(matrix) do
    matrix
    |> scan_horizontal
    |> scan_vertical
    |> scan_diagonal
  end

  defp scan_horizontal(matrix) do
    matrix
    |> Enum.map(&scan_row_horizontal/1)
  end

  defp scan_vertical(matrix) do
    matrix
    |> transpose
    |> Enum.map(&scan_row_horizontal/1)
    |> transpose
  end

  defp scan_diagonal(matrix) do
    matrix
    |> pairs([])
    |> Enum.map(&scan_diagonal_downwards/1)
  end

  defp pairs([], acc) do
    Enum.reverse(acc)
  end

  defp pairs([single_row], acc) do
    pair = [single_row, nil]
    pairs([], [pair | acc])
  end

  defp pairs([row | rows], acc) do
    pair = [row, hd(rows)]
    pairs(rows, [pair | acc])
  end

  def scan_diagonal_downwards([row, nil]) do
    row
  end

  def scan_diagonal_downwards(pair) do
    # IO.inspect pair
    _scan_diagonal_downwards(pair, [])
  end

  # TODO
  defp _scan_diagonal_downwards([row, _bottom_row], _acc) do
    row
  end

  defp scan_row_horizontal(row) do
    scan_right(row, [])
    |> scan_left()
  end

  defp scan_right([], acc) do
    Enum.reverse(acc)
  end

  defp scan_right([x], acc) do
    scan_right([], [x | acc])
  end

  defp scan_right(["*" | tail], acc) do
    scan_right(tail, ["*" | acc])
  end

  defp scan_right([x, "*" | tail], acc) do
    scan_right(tail, ["*", x + 1 | acc])
  end

  defp scan_right([x, y | tail], acc) do
    scan_right(tail, [y, x | acc])
  end

  defp scan_left(row) do
    row |> Enum.reverse |> scan_right([]) |> Enum.reverse
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
