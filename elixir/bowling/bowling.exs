# Elixir v1.5.1
defmodule Bowling do
  defstruct active: nil, frames: [], roll_index: 0

  defmodule Frame do
    defstruct id: 1, type: :active, rolls: [], roll_index: 0, max_rolls: 2, score: 0
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
    game = %{game | roll_index: game.roll_index + 1}
    event = {game.roll_index, roll}
    frame = update_frame(game.active, event)
    game = notify_frames(game, event)
    update_game(game, frame)
  end

  defp update_frame(frame, {roll_index, roll}) do
    rolls = [roll | frame.rolls]
    pins = Enum.sum(rolls)
    type = frame_type(rolls, pins, frame.max_rolls)
    %{frame |
      type: type,
      rolls: rolls,
      roll_index: roll_index,
      score: frame.score + roll
    }
  end

  defp frame_type(rolls, pins, max_rolls) do
    rolls_left = max_rolls - length(rolls)
    case {pins, length(rolls), rolls_left} do
      {pins, _, _} when pins > 10 -> :overflow
      {10,   1, _}                -> :strike
      {10,   2, _}                -> :spare
      {_,    _, 0}                -> :open
      _                           -> :active
    end
  end

  defp notify_frames(game, event) do
    frames = Enum.map(game.frames, fn(frame) -> notify_frame(frame, event) end)
    %{game | frames: frames}
  end

  defp notify_frame(frame, {j, roll}) do
    num_bonus_rolls = num_bonus_rolls(frame)
    dist = j - frame.roll_index
    cond do
      frame.id in [10, :bonus] -> frame
      dist <= num_bonus_rolls  -> %{frame | score: frame.score + roll}
      true                     -> frame
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
    num_bonus_rolls = num_bonus_rolls(frame)
    if num_bonus_rolls > 0 do
      %Frame{id: :bonus, max_rolls: num_bonus_rolls}
    end
  end

  defp next_frame(frame) do
    %Frame{id: frame.id + 1}
  end

  defp num_bonus_rolls(frame) do
    case frame.type do
      :strike -> 2
      :spare  -> 1
      :open   -> 0
    end
  end

  def score(game = %Bowling{active: nil}) do
    game.frames |> Enum.map(&(&1.score)) |> Enum.sum()
  end

  def score(_) do
    {:error, "Score cannot be taken until the end of the game"}
  end
end
