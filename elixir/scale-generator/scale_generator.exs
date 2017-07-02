defmodule ScaleGenerator do

  def chromatic_scale(tonic \\ "C") do
    tonic |> Note.from_tonic |> Scale.chromatic
  end

  def flat_chromatic_scale(tonic \\ "C") do
    tonic |> Note.from_tonic |> Scale.chromatic |> Scale.flat_notation
  end

  def find_chromatic_scale(tonic) do
    tonic |> Note.from_tonic |> Scale.chromatic |> Scale.to_notation(tonic)
  end

  def step(scale, tonic, step) do
    note = Note.from_tonic(tonic)
    scale |> Scale.rotate(note) |> Scale.advance(step) |> hd
  end

  def scale(tonic, pattern) do
    note = Note.from_tonic(tonic)
    steps = String.codepoints(pattern)
    scale = Scale.chromatic(note) |> _scale(steps, []) |> Scale.to_notation(tonic)
    scale ++ [note]
  end

  defp _scale(_, [], acc), do: Enum.reverse(acc)

  defp _scale(notes, [step | steps], acc) do
    next_notes = Scale.advance(notes, step)
    _scale(next_notes, steps, [hd(notes) | acc])
  end
end

defmodule Scale do

  @chromatic_c ~w(C C# D D# E F F# G G# A A# B)

  def to_notation(notes, tonic) do
    case tonic in ~w[F Bb Eb Ab Db Gb d g c f bb eb] do
      true -> notes |> flat_notation
      false -> notes
    end
  end

  def flat_notation(notes) do
    notes |> Enum.map(&Note.flat_notation/1)
  end

  def chromatic(note) do
    rotate(@chromatic_c, Note.sharp_notation(note))
  end

  def rotate(notes, note) do
    rotate_to_target(notes, note, [])
  end

  def advance(notes, step) do
    case step do
      "m" -> Enum.drop(notes, 1)
      "M" -> Enum.drop(notes, 2)
      "A" -> Enum.drop(notes, 3)
    end
  end

  defp rotate_to_target([target | right], target, left) do
    [target | right] ++ Enum.reverse(left) ++ [target]
  end

  defp rotate_to_target([note | right], target, left) do
    rotate_to_target(right, target, [note | left])
  end
end

defmodule Note do

  def from_tonic(tonic) do
    String.capitalize(tonic)
  end

  def flat_notation(note) do
    case sharp?(note) do
      true -> next(note) <> "b"
      false -> note
    end
  end

  def sharp_notation(note) do
    case flat?(note) do
      true -> note |> natural |> prev
      false -> note
    end
  end

  defp sharp?(note) do
    String.ends_with?(note, "#")
  end

  defp flat?(note) do
    String.ends_with?(note, "b")
  end

  defp natural(note) do
    String.slice(note, 0, 1)
  end

  defp prev(note) do
    Scale.chromatic(note) |> Enum.at(-2)
  end

  defp next(note) do
    Scale.chromatic(note) |> Enum.at(1)
  end
end
