defmodule ScaleGenerator do

  @chromatic_c ~w(C C# D D# E F F# G G# A A# B)

  def chromatic_scale(tonic \\ "C") do
    tonic = tonic |> String.capitalize |> sharp_notation
    rotate_to_tonic(@chromatic_c, tonic, [])
  end

  def flat_chromatic_scale(tonic \\ "C") do
    chromatic_scale(tonic) |> flatten_scale
  end

  def find_chromatic_scale(tonic) do
    case tonic in ~w[F Bb Eb Ab Db Gb d g c f bb eb] do
      true -> flat_chromatic_scale(tonic)
      false -> chromatic_scale(tonic)
    end
  end

  def step(_scale, _tonic, step) do
    case step do
      "m" -> "C#"
      "M" -> "D"
      "A" -> "D#"
    end
  end

  def scale(_tonic, _pattern) do
  end

  defp rotate_to_tonic([tonic | right], tonic, left) do
    [tonic | right] ++ Enum.reverse(left) ++ [tonic]
  end

  defp rotate_to_tonic([note | right], tonic, left) do
    rotate_to_tonic(right, tonic, [note | left])
  end

  defp flatten_scale(scale) do
    scale |> Enum.map(&flat_notation/1)
  end

  defp flat_notation(note) do
    case is_sharp(note) do
      true -> next_note(note) <> "b"
      false -> note
    end
  end

  defp sharp_notation(note) do
    case is_flat(note) do
      true -> note |> natural |> prev_note
      false -> note
    end
  end

  defp natural(note) do
    String.slice(note, 0, 1)
  end

  defp is_flat(note) do
    String.ends_with?(note, "b")
  end

  defp is_sharp(note) do
    String.ends_with?(note, "#")
  end

  defp prev_note(note) do
    chromatic_scale(note) |> Enum.at(-2)
  end

  defp next_note(note) do
    chromatic_scale(note) |> Enum.at(1)
  end
end
