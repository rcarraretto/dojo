defmodule ScaleGenerator do

  @chromatic_c ~w(C C# D D# E F F# G G# A A# B)

  def chromatic_scale(tonic \\ "C") do
    note = tonic |> String.capitalize |> sharp_notation
    rotate_to_tonic(@chromatic_c, note, [])
  end

  def flat_chromatic_scale(tonic \\ "C") do
    chromatic_scale(tonic) |> flatten_scale
  end

  def find_chromatic_scale(tonic) do
    chromatic_scale(tonic) |> to_notation(tonic)
  end

  def step(scale, tonic, step) do
    scale |> rotate_to_tonic(tonic, []) |> advance(step) |> hd
  end

  def scale(tonic, pattern) do
    note = String.capitalize(tonic)
    steps = String.codepoints(pattern)
    scale = chromatic_scale(note) |> _scale(steps, []) |> to_notation(tonic)
    scale ++ [note]
  end

  defp to_notation(scale, tonic) do
    case tonic in ~w[F Bb Eb Ab Db Gb d g c f bb eb] do
      true -> scale |> flatten_scale
      false -> scale
    end
  end

  defp _scale(_, [], acc), do: Enum.reverse(acc)

  defp _scale(notes, [step | steps], acc) do
    next_notes = advance(notes, step)
    _scale(next_notes, steps, [hd(notes) | acc])
  end

  defp advance(notes, step) do
    case step do
      "m" -> Enum.drop(notes, 1)
      "M" -> Enum.drop(notes, 2)
      "A" -> Enum.drop(notes, 3)
    end
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
