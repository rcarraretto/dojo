defmodule RotationalCipher do

  def rotate(text, shift) do
    text
      |> to_charlist
      |> Enum.map(&(rotate_char(&1, shift)))
      |> to_string
  end

  defp rotate_char(c, shift) do
    cond do
      lower?(c) -> rotate_lower(c, shift)
      upper?(c) -> rotate_upper(c, shift)
      true -> c
    end
  end

  defp lower?(c) do
    ?a <= c and c <= ?z
  end

  defp upper?(c) do
    ?A <= c and c <= ?Z
  end

  defp rotate_lower(c, shift) do
    rotate_in_alphabet(?a, c, shift)
  end

  defp rotate_upper(c, shift) do
    rotate_in_alphabet(?A, c, shift)
  end

  defp rotate_in_alphabet(start, c, shift) do
    start + rem(c + shift - start, 26)
  end
end
