if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("minesweeper.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule MinesweeperTest do
  use ExUnit.Case

  defp clean(b), do: Enum.map(b, &String.replace(&1, ~r/[^*]/, " "))

  test "assembling" do
    row = [" ", "*", " ", "*", " "]
    a1 = [
      ["*"],
      [" ", " "],
      ["*", "*"],
      [" ", " "],
      ["*"],
    ]
    assert Minesweeper.same_row_neighbors(row) == a1
    row2 = ["*", " ", "*", " ", " "]
    a2 = [
      ["*", " "],
      ["*", " ", "*"],
      [" ", "*", " "],
      ["*", " ", " "],
      [" ", " "],
    ]
    assert Minesweeper.adjacent_row_neighbors(row2) == a2
  end

  test "zero size board" do
    b = []
    a = []
    assert Minesweeper.annotate(b) == a
  end

  test "empty board" do
    b = ["   ",
         "   ",
         "   "]
    a = ["   ",
         "   ",
         "   "]
    assert Minesweeper.annotate((b)) == a
  end

  test "board full of mines" do
    b = ["***",
         "***",
         "***"]
    a = ["***",
         "***",
         "***"]
    assert Minesweeper.annotate((b)) == a
  end

  test "horizontal line" do
    b = [" * * "]
    a = ["1*2*1"]
    assert Minesweeper.annotate((b)) == a
  end

  @tag :pending
  test "vertical line" do
    b = [" ",
         "*",
         " ",
         "*",
         " "]
    a = ["1",
         "*",
         "2",
         "*",
         "1"]
    assert Minesweeper.annotate((b)) == a
  end

  @tag :pending
  test "surrounded" do
    b = ["***",
         "* *",
         "***"]
    a = ["***",
         "*8*",
         "***"]
    assert Minesweeper.annotate((b)) == a
  end

  @tag :pending
  test "cross" do
    b = [" 2*2 ",
         "25*52",
         "*****",
         "25*52",
         " 2*2 "]
    assert Minesweeper.annotate(clean(b)) == b
  end
end
