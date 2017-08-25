# Elixir v1.5.1
defmodule Bowling do
  defstruct active: nil, played: []

  defmodule Frame do
    defstruct id: 1, type: :active, rolls: [], max_rolls: 2
  end

  def start do
    %Bowling{active: %Frame{}}
  end

  def roll(_game, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(%Bowling{active: nil}, _roll) do
    {:error, "Cannot roll after game is over"}
  end

  def roll(game, roll) do
    updated_frame = update_frame(game.active, roll)
    update_game(game, updated_frame)
  end

  defp update_frame(frame, roll) do
    rolls = frame.rolls ++ [roll]
    type = frame_type(rolls, frame.max_rolls)
    %{frame | type: type, rolls: rolls}
  end

  defp frame_type(rolls, max_rolls) do
    pins = Enum.sum(rolls)
    rolls_left = max_rolls - length(rolls)
    case {pins, length(rolls), rolls_left} do
      {pins, _, _} when pins > 10 -> :error
      {10,   1, _}                -> :strike
      {10,   2, _}                -> :spare
      {_,    _, 0}                -> :open
      _                           -> :active
    end
  end

  defp update_game(_game, %Frame{type: :error}) do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp update_game(game, frame = %Frame{type: :active}) do
    %{game | active: frame}
  end

  defp update_game(game, frame) do
    %{game | active: next_frame(frame), played: [frame | game.played]}
  end

  defp next_frame(frame = %Frame{id: :bonus}) do
    rolls_left = frame.max_rolls - length(frame.rolls)
    if rolls_left != 0 do
      %Frame{id: :bonus, max_rolls: rolls_left}
    else
      nil
    end
  end

  defp next_frame(frame = %Frame{id: 10}) do
    times = case frame.type do
      :strike -> 2
      :spare  -> 1
      _       -> 0
    end
    if times > 0 do
      %Frame{id: :bonus, max_rolls: times}
    else
      nil
    end
  end

  defp next_frame(frame) do
    %Frame{id: frame.id + 1}
  end

  def score(game = %Bowling{active: nil}) do
    _score(Enum.reverse(game.played), 0)
  end

  def score(_) do
    {:error, "Score cannot be taken until the end of the game"}
  end

  defp _score([], score) do
    score
  end

  defp _score([frame = %Frame{id: :bonus} | frames], score) do
    _score(frames, score + Enum.sum(frame.rolls))
  end

  defp _score([frame = %Frame{id: 10} | frames], score) do
    _score(frames, score + Enum.sum(frame.rolls))
  end

  defp _score([%Frame{type: :strike} | frames], score) do
    next_rolls = frames
    |> Enum.map(&(&1.rolls))
    |> List.flatten
    |> Enum.take(2)
    frame_score = 10 + Enum.sum(next_rolls)
    _score(frames, score + frame_score)
  end

  defp _score([frame, next | frames], score) do
    frame_score = Enum.sum(frame.rolls)
    frame_score = case frame_score do
      10 -> frame_score + hd(next.rolls)
      _  -> frame_score
    end
    _score([next | frames], score + frame_score)
  end
end
