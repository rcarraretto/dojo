defmodule Sublist do

  def compare(a, a), do: :equal

  def compare(a, b) when length(a) <= length(b) do
    _compare(a, b, [], [])
  end

  def compare(a, b) do
    result = _compare(b, a, [], [])
    case result do
      :sublist -> :superlist
      _ -> result
    end
  end

  defp _compare([], _b, _a2, _b2), do: :sublist
  defp _compare(_a, [], _a2, _b2), do: :unequal

  defp _compare(a, b, a2, b2) do
    case hd(a) === hd(b) do
      true -> _compare(tl(a), tl(b), [hd(a) | a2], [hd(b) | b2])
      false -> reset_compare(a, b, a2, b2)
    end
  end

  defp reset_compare(a, b, a2, b2) do
    restored_a = Enum.reverse(a2) ++ a
    restored_b = Enum.reverse(b2) ++ b
    _compare(restored_a, tl(restored_b), [], [])
  end
end
