# Elixir v1.5.1
defmodule Bowling do
  defstruct frames: [], current: []

  def start do
    %Bowling{}
  end

  def roll(_game, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(_game, roll) when roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(game = %Bowling{frames: frames, current: current}, roll) do
    case length(frames) do
       10 -> %{game | current: [roll | current]}
        _ -> roll_std(game, roll)
    end
  end

  def roll_std(game = %Bowling{frames: frames}, 10) do
    frame = [10]
    %{game | frames: [frame | frames]}
  end

  def roll_std(game = %Bowling{frames: frames, current: [roll1]}, roll2) do
    frame = [roll1, roll2]
    %{game | frames: [frame | frames], current: []}
  end

  def roll_std(game = %Bowling{current: []}, roll1) do
    %{game | current: [roll1]}
  end

  def score(game) do
    frames = case game.current do
      [] -> Enum.reverse(game.frames)
      _  -> Enum.reverse([game.current ++ hd(game.frames) | tl(game.frames)])
    end
    _score(frames, 0)
  end

  defp _score([], score) do
    score
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

  defp _score([[r1, r2]], score) do
    _score([], score + r1 + r2)
  end

  defp _score([last_frame], score) do
    _score([], score + Enum.sum(last_frame))
  end
end
