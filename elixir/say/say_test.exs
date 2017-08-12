if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("say.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule SayTest do
  use ExUnit.Case

  test "say" do
    assert Say.in_english(0) == {:ok, "zero"}
    assert Say.in_english(1) == {:ok, "one"}
    assert Say.in_english(2) == {:ok, "two"}
    assert Say.in_english(3) == {:ok, "three"}
    assert Say.in_english(4) == {:ok, "four"}
    assert Say.in_english(5) == {:ok, "five"}
    assert Say.in_english(6) == {:ok, "six"}
    assert Say.in_english(7) == {:ok, "seven"}
    assert Say.in_english(8) == {:ok, "eight"}
    assert Say.in_english(9) == {:ok, "nine"}
    assert Say.in_english(10) == {:ok, "ten"}
    assert Say.in_english(11) == {:ok, "eleven"}
    assert Say.in_english(12) == {:ok, "twelve"}
    assert Say.in_english(13) == {:ok, "thirteen"}
    assert Say.in_english(14) == {:ok, "fourteen"}
    assert Say.in_english(15) == {:ok, "fifteen"}
    assert Say.in_english(16) == {:ok, "sixteen"}
    assert Say.in_english(17) == {:ok, "seventeen"}
    assert Say.in_english(18) == {:ok, "eighteen"}
    assert Say.in_english(19) == {:ok, "nineteen"}
    assert Say.in_english(20) == {:ok, "twenty"}

    # numbers below zero are out of range
    assert Say.in_english(-1) == {:error, "number is out of range"}

    # numbers above 999,999,999,999 are out of range
    assert Say.in_english(1_000_000_000_000) == {:error, "number is out of range"}
  end

  @tag :pending
  test "twenty-two" do
    assert Say.in_english(22) == {:ok, "twenty-two"}
  end

  @tag :pending
  test "one hundred" do
    assert Say.in_english(100) == {:ok, "one hundred"}
  end

  @tag :pending
  test "one hundred twenty-three" do
    assert Say.in_english(123) == {:ok, "one hundred twenty-three"}
  end

  @tag :pending
  test "one thousand" do
    assert Say.in_english(1_000) == {:ok, "one thousand"}
  end

  @tag :pending
  test "one thousand two hundred thirty-four" do
    assert Say.in_english(1_234) == {:ok, "one thousand two hundred thirty-four"}
  end

  @tag :pending
  test "one million" do
    assert Say.in_english(1_000_000) == {:ok, "one million"}
  end

  @tag :pending
  test "one million two thousand three hundred forty-five" do
    assert Say.in_english(1_002_345) == {:ok, "one million two thousand three hundred forty-five"}
  end

  @tag :pending
  test "one billion" do
    assert Say.in_english(1_000_000_000) == {:ok, "one billion"}
  end

  @tag :pending
  test "a big number" do
    assert Say.in_english(987_654_321_123) == {:ok, "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three"}
  end
end
