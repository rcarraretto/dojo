defmodule ScaleGenerator do

  def scale(tonic, pattern) do
    find_chromatic_scale(tonic) |> Scale.filter_pattern(pattern)
  end

  def find_chromatic_scale(tonic) do
    chromatic_scale(tonic) |> Scale.to_notation(tonic)
  end

  def flat_chromatic_scale(tonic \\ "C") do
    chromatic_scale(tonic) |> Scale.flat_notation
  end

  def chromatic_scale(tonic \\ "C") do
    tonic |> Note.from_tonic |> Scale.chromatic
  end

  def step(scale, tonic, step) do
    note = Note.from_tonic(tonic)
    scale |> Scale.rotate(note) |> Scale.advance(step) |> hd
  end
end

defmodule Scale do

  @chromatic_notes ~w(C C# D D# E F F# G G# A A# B)
  @flat_tonics ~w[F Bb Eb Ab Db Gb d g c f bb eb]
  @step_distances %{ "m" => 1, "M" => 2, "A" => 3 }

  def to_notation(notes, tonic) do
    case tonic in @flat_tonics do
      true -> notes |> flat_notation
      false -> notes
    end
  end

  def flat_notation(notes) do
    notes |> Enum.map(&Note.flat_notation/1)
  end


  def chromatic(note) do
    rotate(@chromatic_notes, Note.sharp_notation(note))
  end

  def rotate(notes, note) do
    {left, right} = Enum.split_while(notes, &(&1 != note))
    right ++ left ++ [note]
  end


  def filter_pattern(notes, pattern) do
    steps = String.codepoints(pattern)
    walk_steps(notes, steps, [])
  end

  defp walk_steps([note | _], [], acc), do: Enum.reverse(acc) ++ [note]

  defp walk_steps(notes, [step | steps], acc) do
    next_notes = advance(notes, step)
    walk_steps(next_notes, steps, [hd(notes) | acc])
  end

  def advance(notes, step) do
    Enum.drop(notes, @step_distances[step])
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
