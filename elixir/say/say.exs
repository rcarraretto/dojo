defmodule Say do

  def in_english(0) do
    {:ok, "zero"}
  end

  def in_english(number) when 0 < number and number < 999_999_999_999 do
    english = number |> groups() |> groups_eng()
    {:ok, english}
  end

  def in_english(_) do
    {:error, "number is out of range"}
  end

  defp groups(number) do
    _groups(number, [])
  end

  defp _groups(0, acc) do
    acc
  end

  defp _groups(memo, acc) do
    _groups(div(memo, 1000), [rem(memo, 1000) | acc])
  end

  defp groups_eng(groups) do
    length = length(groups)
    groups
    |> Enum.with_index
    |> Enum.reduce([], fn({num_3d, index}, acc) ->
      [group_eng(length - index, num_3d) | acc]
    end)
    |> Enum.reverse
    |> Enum.join(" ")
    |> String.trim
  end

  defp group_eng(group_index, num_3d) do
    "#{num_3d_eng(num_3d)} #{group_name(group_index)}"
  end

  defp group_name(0), do: ''
  defp group_name(1), do: ''
  defp group_name(2), do: 'thousand'
  defp group_name(3), do: 'million'
  defp group_name(4), do: 'billion'

  defp num_3d_eng(num_3d) do
    hundreds = div(num_3d, 100)
    num_2d = rem(num_3d, 100)
    tens = div(num_2d, 10)
    ones = rem(num_2d, 10)
    tuple_eng({num_3d, hundreds, tens, ones})
  end

  defp tuple_eng({number, 0, tens, ones}) do
    "#{num_2d_eng({number, tens, ones})}"
  end

  defp tuple_eng({number, hundreds, tens, ones}) do
    "#{num_eng(hundreds)} hundred #{num_2d_eng({number, tens, ones})}"
  end

  defp num_2d_eng({number, tens, ones}) do
    num_2d = rem(number, 100)
    eng = num_eng(num_2d)
    if eng do
      eng
    else
      [num_eng(tens * 10), num_eng(ones)]
      |> Enum.filter(&(&1 != nil))
      |> Enum.join("-")
    end
  end

  defp num_eng(1), do: "one"
  defp num_eng(2), do: "two"
  defp num_eng(3), do: "three"
  defp num_eng(4), do: "four"
  defp num_eng(5), do: "five"
  defp num_eng(6), do: "six"
  defp num_eng(7), do: "seven"
  defp num_eng(8), do: "eight"
  defp num_eng(9), do: "nine"
  defp num_eng(10), do: "ten"
  defp num_eng(11), do: "eleven"
  defp num_eng(12), do: "twelve"
  defp num_eng(13), do: "thirteen"
  defp num_eng(14), do: "fourteen"
  defp num_eng(15), do: "fifteen"
  defp num_eng(16), do: "sixteen"
  defp num_eng(17), do: "seventeen"
  defp num_eng(18), do: "eighteen"
  defp num_eng(19), do: "nineteen"
  defp num_eng(20), do: "twenty"
  defp num_eng(30), do: "thirty"
  defp num_eng(40), do: "forty"
  defp num_eng(50), do: "fifty"
  defp num_eng(60), do: "sixty"
  defp num_eng(70), do: "seventy"
  defp num_eng(80), do: "eighty"
  defp num_eng(90), do: "ninty"
  defp num_eng(_), do: nil
end
