# Elixir v1.5.1
defmodule Bowling do
  defstruct frame_num: 1, frames: [], bonus: [], current: []

  def start do
    %Bowling{}
  end

  def roll(_game, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(_game, roll) when roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(game = %Bowling{frame_num: 11, bonus: bonus}, roll) do
    %{game | bonus: [roll | bonus]}
  end

  def roll(game, 10) do
    end_frame(game, [10])
  end

  def roll(game = %Bowling{current: [roll1]}, roll2) do
    end_frame(game, [roll1, roll2])
  end

  def roll(game = %Bowling{current: []}, roll1) do
    %{game | current: [roll1]}
  end

  defp end_frame(game, frame) do
    %{
      game |
      frame_num: game.frame_num + 1,
      frames: [frame | game.frames],
      current: []
    }
  end

  def score(game) do
    frames = case game.bonus do
      [] -> Enum.reverse(game.frames)
      _  -> Enum.reverse([game.bonus ++ hd(game.frames) | tl(game.frames)])
    end
    _score(frames, 0)
  end

  defp _score([], score) do
    score
  end

  defp _score([last_frame], score) do
    _score([], score + Enum.sum(last_frame))
  end

  defp _score([[10] | frames], score) do
    next_rolls = frames |> List.flatten |> Enum.take(2)
    frame_score = 10 + Enum.sum(next_rolls)
    _score(frames, score + frame_score)
  end

  defp _score([[r1, r2], next | frames], score) do
    frame_score = r1 + r2
    frame_score = case frame_score do
      10 -> frame_score + hd(next)
      _  -> frame_score
    end
    _score([next | frames], score + frame_score)
  end
end
