# Elixir v1.5.1
defmodule Bowling do

  def start do
    []
  end

  def roll(game, roll) do
    [roll | game]
  end

  def score(game) do
    frames = Enum.chunk_every(Enum.reverse(game), 2, 2, [])
    Enum.chunk_every(frames, 2, 1, [])
    |> Enum.map(&score_frame/1)
    |> Enum.sum()
  end

  defp score_frame([[roll1, roll2]]) do
    roll1 + roll2
  end

  defp score_frame([[last_roll]]) do
    last_roll
  end

  defp score_frame([[roll1, roll2], [_last_roll]]) do
    roll1 + roll2
  end

  defp score_frame([[roll1, roll2], [next_roll1, _next_roll2]]) do
    score = roll1 + roll2
    case score do
      10 -> score + next_roll1
      _ -> score
    end
  end
end
