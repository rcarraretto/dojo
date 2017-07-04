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
    |> left_and_right
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

  defp left_and_right(matrix) do
    matrix
    |> Enum.map(&left_and_right_row/1)
    |> transpose
    |> Enum.map(&left_and_right_row/1)
    |> transpose
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
end
