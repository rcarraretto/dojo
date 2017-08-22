# Elixir v1.5.1
defmodule Bowling do
  defstruct frames: [], current: []

  def start do
    %Bowling{}
  end

  def roll(game = %Bowling{frames: frames}, 10) do
    frame = [10]
    %{game | frames: [frame | frames]}
  end

  def roll(game = %Bowling{frames: frames, current: [roll1]}, roll2) do
    frame = [roll1, roll2]
    %{game | frames: [frame | frames], current: []}
  end

  def roll(game = %Bowling{current: []}, roll1) do
    %{game | current: [roll1]}
  end

  def score(game) do
    frames = case game.current do
      [] -> Enum.reverse(game.frames)
      _  -> Enum.reverse([game.current | game.frames])
    end
    Enum.chunk_every(frames, 2, 1, [])
    |> Enum.map(&score_frame/1)
    |> Enum.sum()
  end

  defp score_frame([[10], [next_roll1, next_roll2]]) do
    10 + next_roll1 + next_roll2
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
