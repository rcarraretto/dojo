defmodule Say do

  def in_english(0) do
    {:ok, "zero"}
  end

  def in_english(number) when 0 < number and number < 999_999_999_999 do
    english = number |> groups_of_3d() |> groups_eng()
    {:ok, english}
  end

  def in_english(_) do
    {:error, "number is out of range"}
  end

  defp groups_of_3d(number) do
    _groups_of_3d(number, [])
  end

  defp _groups_of_3d(0, acc) do
    Enum.reverse(acc)
  end

  defp _groups_of_3d(number, acc) do
    _groups_of_3d(div(number, 1000), [rem(number, 1000) | acc])
  end

  defp groups_eng(groups) do
    groups
    |> Enum.with_index()
    |> Enum.map(&group_eng/1)
    |> Enum.reverse
    |> Enum.join(" ")
    |> String.trim()
  end

  defp group_eng({0, _group_index}) do
    ""
  end

  defp group_eng({num_3d, group_index}) do
    "#{num_3d_eng(num_3d)} #{group_name(group_index)}"
  end

  defp group_name(0), do: ""
  defp group_name(1), do: "thousand"
  defp group_name(2), do: "million"
  defp group_name(3), do: "billion"

  defp num_3d_eng(num_3d) do
    hundreds = div(num_3d, 100)
    case hundreds do
      0 -> "#{num_2d_eng(num_3d)}"
      _ -> "#{num_2d_eng(hundreds)} hundred #{num_2d_eng(num_3d)}"
    end
  end

  defp num_2d_eng(0), do: nil
  defp num_2d_eng(1), do: "one"
  defp num_2d_eng(2), do: "two"
  defp num_2d_eng(3), do: "three"
  defp num_2d_eng(4), do: "four"
  defp num_2d_eng(5), do: "five"
  defp num_2d_eng(6), do: "six"
  defp num_2d_eng(7), do: "seven"
  defp num_2d_eng(8), do: "eight"
  defp num_2d_eng(9), do: "nine"
  defp num_2d_eng(10), do: "ten"
  defp num_2d_eng(11), do: "eleven"
  defp num_2d_eng(12), do: "twelve"
  defp num_2d_eng(13), do: "thirteen"
  defp num_2d_eng(14), do: "fourteen"
  defp num_2d_eng(15), do: "fifteen"
  defp num_2d_eng(16), do: "sixteen"
  defp num_2d_eng(17), do: "seventeen"
  defp num_2d_eng(18), do: "eighteen"
  defp num_2d_eng(19), do: "nineteen"
  defp num_2d_eng(20), do: "twenty"
  defp num_2d_eng(30), do: "thirty"
  defp num_2d_eng(40), do: "forty"
  defp num_2d_eng(50), do: "fifty"
  defp num_2d_eng(60), do: "sixty"
  defp num_2d_eng(70), do: "seventy"
  defp num_2d_eng(80), do: "eighty"
  defp num_2d_eng(90), do: "ninty"

  defp num_2d_eng(num_3d) do
    num_2d = rem(num_3d, 100)
    tens = num_2d |> div(10) |> Kernel.*(10) |> num_2d_eng()
    ones = num_2d |> rem(10) |> num_2d_eng()
    if ones, do: "#{tens}-#{ones}", else: tens
  end
end
