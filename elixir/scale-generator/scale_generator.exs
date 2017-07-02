defmodule ScaleGenerator do

  @chromatic_c ~w(C C# D D# E F F# G G# A A# B)

  def step(_scale, _tonic, step) do
    case step do
      "m" -> "C#"
      "M" -> "D"
      "A" -> "D#"
    end
  end

  def chromatic_scale(tonic \\ "C") do
    tonic = tonic |> String.capitalize |> sharp_notation
    rotate_to_tonic(@chromatic_c, tonic, [])
  end

  defp rotate_to_tonic([tonic | right], tonic, left) do
    [tonic | right] ++ Enum.reverse(left) ++ [tonic]
  end

  defp rotate_to_tonic([note | right], tonic, left) do
    rotate_to_tonic(right, tonic, [note | left])
  end

  def flat_chromatic_scale(tonic \\ "C") do
    chromatic_scale(tonic) |> flatten_scale
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

  def find_chromatic_scale(_tonic) do
  end

  def scale(_tonic, _pattern) do
  end
end

# Find the note for a given interval (`step`) in a `scale` after the `tonic`.

# "m": one semitone
# "M": two semitones (full tone)
# "A": augmented second (three semitones)

# Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
# should return the following notes for the given `step`:

# "m": D#
# "M": E
# "A": F

# The chromatic scale is a musical scale with thirteen pitches, each a semitone
# (half-tone) above or below another.

# Notes with a sharp (#) are a semitone higher than the note below them, where
# the next letter note is a full tone except in the case of B and E, which have
# no sharps.

# Generate these notes, starting with the given `tonic` and wrapping back
# around to the note before it, ending with the tonic an octave higher than the
# original. If the `tonic` is lowercase, capitalize it.

# "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)

# Sharp notes can also be considered the flat (b) note of the tone above them,
# so the notes can also be represented as:

# A Bb B C Db D Eb E F Gb G Ab

# Generate these notes, starting with the given `tonic` and wrapping back
# around to the note before it, ending with the tonic an octave higher than the
# original. If the `tonic` is lowercase, capitalize it.

# "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)

# Certain scales will require the use of the flat version, depending on the
# `tonic` (key) that begins them, which is C in the above examples.

# For any of the following tonics, use the flat chromatic scale:

# F Bb Eb Ab Db Gb d g c f bb eb

# For all others, use the regular chromatic scale.

# The `pattern` string will let you know how many steps to make for the next
# note in the scale.

# For example, a C Major scale will receive the pattern "MMmMMMm", which
# indicates you will start with C, make a full step over C# to D, another over
# D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
# can follow the rest of the pattern to get:

# C D E F G A B C
