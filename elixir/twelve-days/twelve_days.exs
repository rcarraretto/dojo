defmodule TwelveDays do
  @ordinals %{
    1 => 'first',
    2 => 'second',
    3 => 'third',
    4 => 'fourth',
    5 => 'fifth',
    6 => 'sixth',
    7 => 'seventh',
    8 => 'eighth',
    9 => 'ninth',
    10 => 'tenth',
    11 => 'eleventh',
    12 => 'twelfth',
  }

  @items [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
  ]

  def verse(number) do
    "#{on_the_day(number)} my true love gave to me, #{items(number)}"
  end

  defp on_the_day(number) do
    "On the #{@ordinals[number]} day of Christmas"
  end

  defp items(number) do
    @items |> Enum.take(number) |> Enum.reverse |> item_sentence
  end

  defp item_sentence([item]), do: item
  defp item_sentence([before_last, last]) do
    "#{before_last}, and #{last}"
  end
  defp item_sentence([head | tail]) do
    "#{head}, #{item_sentence(tail)}"
  end

  def verses(_starting_verse, _ending_verse) do
  end

  def sing do
  end
end
