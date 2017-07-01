defmodule PigLatin do

  def translate(phrase) do
    phrase
      |> String.split
      |> Enum.map(&translate_word/1)
      |> Enum.join(" ")
  end

  def translate_word(word) do
    word
      |> String.codepoints
      |> translate_cp
      |> Enum.concat(["ay"])
      |> to_string
  end

  def translate_cp([ a, b, c | rest ]) do
    cond do
      a <> b <> c == "sch" -> [ rest, "sch" ]
      a <> b <> c == "squ" -> [ rest, "squ" ]
      a <> b <> c == "thr" -> [ rest, "thr" ]
      a <> b == "ch" -> [ c, rest, "ch" ]
      a <> b == "qu" -> [ c, rest, "qu" ]
      a <> b == "th" -> [ c, rest, "th" ]
      a =~ ~r/[aeiou]/ -> [ a, b, c, rest ]
      a <> b == "yt" -> [ a, b, c, rest ]
      a <> b == "xr" -> [ a, b, c, rest ]
      true -> [ b, c, rest, a ]
    end
  end
end
