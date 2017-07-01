# backup 20170415 20:47
defmodule RotationalCipher do

  def rotate(text, shift) do
    do_rotate(text, rem(shift, 26))
  end

  defp do_rotate(text, shift) do
    text
      |> String.to_charlist
      |> Enum.map(rot_by(shift))
      |> to_string
  end

  defp rot_by(shift) do
    fn(i) ->
      if alpha?(i), do: shift_alpha(i, shift), else: i
    end
  end

  defp alpha?(i) do
    String.match? << i :: utf8 >>, ~r/[a-zA-Z]/
  end

  defp shift_alpha(i, shift) do
    shifted = i + shift
    if ?a <= i && i <= ?z do
      if shifted > ?z, do: shifted - (?z - ?a + 1), else: shifted
    else
      if shifted > ?Z, do: shifted - (?Z - ?A + 1), else: shifted
    end
  end
end
