defmodule ScaleGenerator do

  @chromatic_sharp ~w(C C# D D# E F F# G G# A A# B)
  @chromatic_flat ~w(C Db D Eb E F Gb G Ab A Bb B)
  @flat_tonics ~w[F Bb Eb Ab Db Gb d g c f bb eb]

  def scale(tonic, pattern) do
    find_chromatic_scale(tonic) |> Scale.filter_pattern(pattern)
  end

  def find_chromatic_scale(tonic) do
    case tonic in @flat_tonics do
      true -> flat_chromatic_scale(tonic)
      false -> chromatic_scale(tonic)
    end
  end

  def flat_chromatic_scale(tonic \\ "C") do
    note = Note.from_tonic(tonic)
    Scale.rotate(@chromatic_flat, note)
  end

  def chromatic_scale(tonic \\ "C") do
    note = Note.from_tonic(tonic)
    Scale.rotate(@chromatic_sharp, note)
  end

  def step(scale, tonic, step) do
    note = Note.from_tonic(tonic)
    Scale.rotate(scale, note)
      |> Scale.advance(step)
      |> hd
  end
end

defmodule Scale do

  @step_distances %{ "m" => 1, "M" => 2, "A" => 3 }

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
end
