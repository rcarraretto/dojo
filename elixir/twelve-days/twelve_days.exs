defmodule TwelveDays do
  @ordinals %{
    1 => "first",
    2 => "second",
    3 => "third",
    4 => "fourth",
    5 => "fifth",
    6 => "sixth",
    7 => "seventh",
    8 => "eighth",
    9 => "ninth",
    10 => "tenth",
    11 => "eleventh",
    12 => "twelfth",
  }

  @quantities %{
    1 => "a",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
  }

  @gifts [
    "Partridge in a Pear Tree",
    "Turtle Doves",
    "French Hens",
    "Calling Birds",
    "Gold Rings",
    "Geese-a-Laying",
    "Swans-a-Swimming",
    "Maids-a-Milking",
    "Ladies Dancing",
    "Lords-a-Leaping",
    "Pipers Piping",
    "Drummers Drumming",
  ]

  def sing, do: verses(1, 12)

  def verses(from, to) do
    from..to
      |> Enum.map(&verse/1)
      |> Enum.join("\n")
  end

  def verse(number) do
    "#{on_the_day(number)} my true love gave to me, #{gifts(number)}."
  end

  defp on_the_day(number) do
    "On the #{@ordinals[number]} day of Christmas"
  end

  defp gifts(number) do
    @gifts
      |> Enum.take(number)
      |> with_quantity
      |> Enum.reverse
      |> comma_separated
  end

  defp with_quantity(gifts) do
    gifts
      |> Enum.with_index
      |> Enum.map(fn({ gift, index }) -> @quantities[index + 1] <> " " <> gift end)
  end

  defp comma_separated([only_one]), do: only_one
  defp comma_separated([before_last, last]) do
    "#{before_last}, and #{last}"
  end
  defp comma_separated([head | tail]) do
    "#{head}, #{comma_separated(tail)}"
  end
end
