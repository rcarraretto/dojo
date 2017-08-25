# Elixir v1.5.1
defmodule Bowling do
  defstruct active: nil, frames: []

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
    rolls = [roll | frame.rolls]
    type = frame_type(rolls, frame.max_rolls)
    %{frame | type: type, rolls: rolls}
  end

  defp frame_type(rolls, max_rolls) do
    rolls_left = max_rolls - length(rolls)
    case {num_pins(rolls), length(rolls), rolls_left} do
      {pins, _, _} when pins > 10 -> :overflow
      {10,   1, _}                -> :strike
      {10,   2, _}                -> :spare
      {_,    _, 0}                -> :open
      _                           -> :active
    end
  end

  defp update_game(_game, %Frame{type: :overflow}) do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp update_game(game, frame = %Frame{type: :active}) do
    %{game | active: frame}
  end

  defp update_game(game, frame) do
    %{game | active: next_frame(frame), frames: [frame | game.frames]}
  end

  defp next_frame(frame = %Frame{id: :bonus}) do
    num_bonus_rolls_left = frame.max_rolls - length(frame.rolls)
    if num_bonus_rolls_left != 0 do
      %Frame{id: :bonus, max_rolls: num_bonus_rolls_left}
    end
  end

  defp next_frame(frame = %Frame{id: 10}) do
    num_bonus_rolls = case frame.type do
      :strike -> 2
      :spare  -> 1
      :open   -> 0
    end
    if num_bonus_rolls > 0 do
      %Frame{id: :bonus, max_rolls: num_bonus_rolls}
    end
  end

  defp next_frame(frame) do
    %Frame{id: frame.id + 1}
  end

  def score(game = %Bowling{active: nil}) do
    frames = Enum.reverse(game.frames)
    rolls = frames
    |> Enum.map(fn(frame) -> Enum.reverse(frame.rolls) end)
    |> List.flatten

    {score, []} = Enum.reduce(frames, {0, rolls}, fn(frame, {score, rolls}) ->
      rolls_left = Enum.drop(rolls, length(frame.rolls))
      new_score = score + frame_score(frame, rolls_left)
      {new_score, rolls_left}
    end)

    score
  end

  def score(_) do
    {:error, "Score cannot be taken until the end of the game"}
  end

  defp frame_score(frame, rolls) do
    if has_special_score?(frame) do
      special_score(frame, rolls)
    else
      num_pins(frame)
    end
  end

  defp has_special_score?(%Frame{id: id, type: type}) do
    id in 1..9 and type in [:spare, :strike]
  end

  defp special_score(frame, rolls) do
    num_next_rolls = if frame.type == :strike, do: 2, else: 1
    next_rolls = Enum.take(rolls, num_next_rolls)
    num_pins(frame) + num_pins(next_rolls)
  end

  defp num_pins(%Frame{rolls: rolls}) do
    num_pins(rolls)
  end

  defp num_pins(rolls) do
    Enum.sum(rolls)
  end
end
