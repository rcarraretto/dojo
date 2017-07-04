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
    |> Enum.map(&left_and_right_row/1)
  end

  defp scan_vertical(matrix) do
    matrix
    |> transpose
    |> Enum.map(&left_and_right_row/1)
    |> transpose
  end

  defp scan_diagonal(matrix) do
    matrix
  end

  defp left_and_right_row(row) do
    add_right(row, [])
    |> add_left()
  end

  defp add_right([], acc) do
    Enum.reverse(acc)
  end

  defp add_right([x], acc) do
    add_right([], [x | acc])
  end

  defp add_right(["*" | tail], acc) do
    add_right(tail, ["*" | acc])
  end

  defp add_right([x, "*" | tail], acc) do
    add_right(tail, ["*", x + 1 | acc])
  end

  defp add_right([x, y | tail], acc) do
    add_right(tail, [y, x | acc])
  end

  defp add_left(row) do
    row |> Enum.reverse |> add_right([]) |> Enum.reverse
  end

  defp transpose(matrix) do
    List.zip(matrix) |> Enum.map(&Tuple.to_list/1)
  end

  def diagonals(matrix) do
    _diagonals(matrix, [])
  end

  defp _diagonals([], diagonals) do
    Enum.reverse(diagonals)
  end

  defp _diagonals(rows, diagonals) do
    { rows, diagonal } = _diagonal(rows, 0, { [], [] })
    # IO.inspect rows
    # IO.inspect diagonal
    _diagonals(rows, [diagonal | diagonals])
  end

  defp _diagonal([], _col_index, { new_rows, diagonal }) do
    diagonal = diagonal |> Enum.filter(fn(x) -> x != nil end)
    { Enum.reverse(new_rows), Enum.reverse(diagonal) }
  end

  defp _diagonal([row | rows], col_index, { new_rows, diagonal }) do
    elem = Enum.at(row, col_index)
    diagonal = [elem | diagonal]
    new_row = List.delete_at(row, col_index)
    new_rows = case Enum.empty?(new_row) do
      true -> new_rows
      false -> [new_row | new_rows]
    end
    _diagonal(rows, col_index + 1, { new_rows, diagonal })
  end
end
