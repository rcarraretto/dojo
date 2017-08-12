defmodule Say do

  def english(0), do: "zero"
  def english(1), do: "one"
  def english(2), do: "two"
  def english(3), do: "three"
  def english(4), do: "four"
  def english(5), do: "five"
  def english(6), do: "six"
  def english(7), do: "seven"
  def english(8), do: "eight"
  def english(9), do: "nine"
  def english(10), do: "ten"
  def english(11), do: "eleven"
  def english(12), do: "twelve"
  def english(13), do: "thirteen"
  def english(14), do: "fourteen"
  def english(15), do: "fifteen"
  def english(16), do: "sixteen"
  def english(17), do: "seventeen"
  def english(18), do: "eighteen"
  def english(19), do: "nineteen"
  def english(20), do: "twenty"
  def english(_), do: :error

  def in_english(number) do
    case english(number) do
      :error -> {:error, "number is out of range"}
      english -> {:ok, english}
    end
  end
end
