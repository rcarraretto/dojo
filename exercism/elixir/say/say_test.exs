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
    assert Say.in_english(22) == {:ok, "twenty-two"}
    assert Say.in_english(50) == {:ok, "fifty"}
    assert Say.in_english(60) == {:ok, "sixty"}
    assert Say.in_english(70) == {:ok, "seventy"}
    assert Say.in_english(80) == {:ok, "eighty"}
    assert Say.in_english(90) == {:ok, "ninty"}

    assert Say.in_english(100) == {:ok, "one hundred"}
    assert Say.in_english(123) == {:ok, "one hundred twenty-three"}

    assert Say.in_english(1_000) == {:ok, "one thousand"}
    assert Say.in_english(1_001) == {:ok, "one thousand one"}
    assert Say.in_english(1_234) == {:ok, "one thousand two hundred thirty-four"}

    assert Say.in_english(100_000) == {:ok, "one hundred thousand"}

    assert Say.in_english(1_000_000) == {:ok, "one million"}
    assert Say.in_english(1_002_345) == {:ok, "one million two thousand three hundred forty-five"}

    assert Say.in_english(1_000_000_000) == {:ok, "one billion"}

    assert Say.in_english(987_654_321_123) == {:ok, "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three"}
    assert Say.in_english(999_999_999_999) == {:ok, "nine hundred ninty-nine billion nine hundred ninty-nine million nine hundred ninty-nine thousand nine hundred ninty-nine"}

    assert Say.in_english(-1) == {:error, "number is out of range"}
    assert Say.in_english(1_000_000_000_000) == {:error, "number is out of range"}
  end
end
