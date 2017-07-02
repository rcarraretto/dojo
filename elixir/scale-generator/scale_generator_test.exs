if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("scale_generator.exs", __DIR__)
end

ExUnit.start
ExUnit.configure trace: true, exclude: :pending

defmodule ScaleGeneratorTest do
  use ExUnit.Case

  # @major_scale_pattern           "MMmMMMm"
  # @minor_scale_pattern           "MmMMmMM"
  # @dorian_scale_pattern          "MmMMMmM"
  # @mixolydian_scale_pattern      "MMmMMmM"
  # @lydian_scale_pattern          "MMMmMMm"
  # @phrygian_scale_pattern        "mMMMmMM"
  # @locrian_scale_pattern         "mMMmMMM"
  # @harmonic_minor_scale_pattern  "MmMMmAm"
  # @melodic_minor_scale_pattern   "MmMMMMm"
  # @octatonic_scale_pattern       "MmMmMmMm"
  # @hexatonic_scale_pattern       "MMMMMM"
  # @pentatonic_scale_pattern      "MMAMA"
  # @enigmatic_scale_pattern       "mAMMMmm"

  test "chromatic scale" do
    assert ScaleGenerator.chromatic_scale("C") == ~w(C C# D D# E F F# G G# A A# B C)
    assert ScaleGenerator.chromatic_scale("A") == ~w(A A# B C C# D D# E F F# G G# A)
    assert ScaleGenerator.chromatic_scale("G") == ~w(G G# A A# B C C# D D# E F F# G)
    assert ScaleGenerator.chromatic_scale("f#") == ~w(F# G G# A A# B C C# D D# E F F#)
    assert ScaleGenerator.chromatic_scale("Gb") == ~w(F# G G# A A# B C C# D D# E F F#)
    assert ScaleGenerator.chromatic_scale("Bb") == ~w(A# B C C# D D# E F F# G G# A A#)
    assert ScaleGenerator.chromatic_scale("B") == ~w(B C C# D D# E F F# G G# A A# B)
  end

  test "flat chromatic scale" do
    assert ScaleGenerator.flat_chromatic_scale("C") == ~w(C Db D Eb E F Gb G Ab A Bb B C)
    assert ScaleGenerator.flat_chromatic_scale("A") == ~w(A Bb B C Db D Eb E F Gb G Ab A)
    assert ScaleGenerator.flat_chromatic_scale("G") == ~w(G Ab A Bb B C Db D Eb E F Gb G)
    assert ScaleGenerator.flat_chromatic_scale("f#") == ~w(Gb G Ab A Bb B C Db D Eb E F Gb)
    assert ScaleGenerator.flat_chromatic_scale("Gb") == ~w(Gb G Ab A Bb B C Db D Eb E F Gb)
    assert ScaleGenerator.flat_chromatic_scale("Bb") == ~w(Bb B C Db D Eb E F Gb G Ab A Bb)
    assert ScaleGenerator.flat_chromatic_scale("B") == ~w(B C Db D Eb E F Gb G Ab A Bb B)
  end

  test "find chromatic scale" do
    # Per doc block:
    # For any of the following tonics, use the flat chromatic scale:
    # F Bb Eb Ab Db Gb d g c f bb eb
    # For all others, use the regular chromatic scale.

    # flat tonics
    assert ScaleGenerator.find_chromatic_scale("F") == ~w(F Gb G Ab A Bb B C Db D Eb E F)
    assert ScaleGenerator.find_chromatic_scale("Bb") == ~w(Bb B C Db D Eb E F Gb G Ab A Bb)
    assert ScaleGenerator.find_chromatic_scale("Eb") == ~w(Eb E F Gb G Ab A Bb B C Db D Eb)
    assert ScaleGenerator.find_chromatic_scale("Ab") == ~w(Ab A Bb B C Db D Eb E F Gb G Ab)
    assert ScaleGenerator.find_chromatic_scale("Db") == ~w(Db D Eb E F Gb G Ab A Bb B C Db)
    assert ScaleGenerator.find_chromatic_scale("Gb") == ~w(Gb G Ab A Bb B C Db D Eb E F Gb)
    assert ScaleGenerator.find_chromatic_scale("d") == ~w(D Eb E F Gb G Ab A Bb B C Db D)
    assert ScaleGenerator.find_chromatic_scale("g") == ~w(G Ab A Bb B C Db D Eb E F Gb  G)
    assert ScaleGenerator.find_chromatic_scale("c") == ~w(C Db D Eb E F Gb G Ab A Bb B  C)
    assert ScaleGenerator.find_chromatic_scale("f") == ~w(F Gb G Ab A Bb B C Db D Eb E F)
    assert ScaleGenerator.find_chromatic_scale("bb") == ~w(Bb B C Db D Eb E F Gb G Ab A Bb)
    assert ScaleGenerator.find_chromatic_scale("eb") == ~w(Eb E F Gb G Ab A Bb B C Db D Eb)

    # non-flat tonics
    assert ScaleGenerator.find_chromatic_scale("C") == ~w(C C# D D# E F F# G G# A A# B C)
    assert ScaleGenerator.find_chromatic_scale("G") == ~w(G G# A A# B C C# D D# E F F# G)
    assert ScaleGenerator.find_chromatic_scale("D") == ~w(D D# E F F# G G# A A# B C C# D)
    assert ScaleGenerator.find_chromatic_scale("A") == ~w(A A# B C C# D D# E F F# G G# A)
    assert ScaleGenerator.find_chromatic_scale("E") == ~w(E F F# G G# A A# B C C# D D# E)
    assert ScaleGenerator.find_chromatic_scale("B") == ~w(B C C# D D# E F F# G G# A A# B)
    assert ScaleGenerator.find_chromatic_scale("F#") == ~w(F# G G# A A# B C C# D D# E F F#)
    assert ScaleGenerator.find_chromatic_scale("A#") == ~w(A# B C C# D D# E F F# G G# A A#)
    assert ScaleGenerator.find_chromatic_scale("C#") == ~w(C# D D# E F F# G G# A A# B C C#)
    assert ScaleGenerator.find_chromatic_scale("D#") == ~w(D# E F F# G G# A A# B C C# D D#)
    assert ScaleGenerator.find_chromatic_scale("G#") == ~w(G# A A# B C C# D D# E F F# G G#)
  end

  test "step to next note" do
    assert ScaleGenerator.step(~w(C C# D D# E F F# G G# A A# B), "C", "m") == "C#"
    assert ScaleGenerator.step(~w(C C# D D# E F F# G G# A A# B), "C", "M") == "D"
    assert ScaleGenerator.step(~w(C C# D D# E F F# G G# A A# B), "C", "A") == "D#"
  end

  test "generate scale from tonic and pattern" do
    # assert ScaleGenerator.scale("C", @major_scale_pattern) == ~w(C D E F G A B C)
    # assert ScaleGenerator.scale("G", @major_scale_pattern) == ~w(G A B C D E F# G)
    # assert ScaleGenerator.scale("f#", @minor_scale_pattern) == ~w(F# G# A B C# D E F#)
    # assert ScaleGenerator.scale("bb", @minor_scale_pattern) == ~w(Bb C Db Eb F Gb Ab Bb)
    # assert ScaleGenerator.scale("d", @dorian_scale_pattern) == ~w(D E F G A B C D)
    # assert ScaleGenerator.scale("Eb", @mixolydian_scale_pattern) == ~w(Eb F G Ab Bb C Db Eb)
    # assert ScaleGenerator.scale("a", @lydian_scale_pattern) == ~w(A B C# D# E F# G# A)
    # assert ScaleGenerator.scale("e", @phrygian_scale_pattern) == ~w(E F G A B C D E)
    # assert ScaleGenerator.scale("g", @locrian_scale_pattern) == ~w(G Ab Bb C Db Eb F G)
    # assert ScaleGenerator.scale("d", @harmonic_minor_scale_pattern) == ~w(D E F G A Bb Db D)
    # assert ScaleGenerator.scale("C", @melodic_minor_scale_pattern) == ~w(C D D# F G A B C)
    # assert ScaleGenerator.scale("C", @octatonic_scale_pattern) == ~w(C D D# F F# G# A B C)
    # assert ScaleGenerator.scale("Db", @hexatonic_scale_pattern) == ~w(Db Eb F G A B Db)
    # assert ScaleGenerator.scale("A", @pentatonic_scale_pattern) == ~w(A B C# E F# A)
    # assert ScaleGenerator.scale("G", @enigmatic_scale_pattern) == ~w(G G# B C# D# F F# G)
  end
end
