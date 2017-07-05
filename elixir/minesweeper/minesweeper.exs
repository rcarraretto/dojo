defmodule Minesweeper do

  def annotate(board) do
    board
    |> to_matrix
    |> annotate_matrix
  end

  defp to_matrix(board) do
    board
    |> Enum.map(fn(row) -> String.codepoints(row) end)
    |> Enum.map(&init_row/1)
  end

  defp init_row(row) do
    row
    |> Enum.map(fn(x) ->
      case x == " " do
        true -> 0
        false -> x
      end
    end)
  end

  defp annotate_matrix(matrix) do
    matrix
    |> scan_horizontal
    |> scan_vertical
    |> scan_diagonal
    |> Enum.map(&to_board/1)
  end

  defp to_board(row) do
    row
    |> Enum.map(fn(x) ->
      cond do
        x == 0 -> " "
        is_integer(x) -> Integer.to_string(x)
        true -> x
      end
    end)
    |> Enum.join
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
