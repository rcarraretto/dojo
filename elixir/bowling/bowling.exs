# Elixir v1.5.1
defmodule Frame do
  defstruct id: 1, type: :active, rolls: [], roll_index: 0, max_rolls: 2, score: 0

  def roll(frame, {roll_index, roll}) do
    rolls = [roll | frame.rolls]
    type = frame_type(rolls, frame.max_rolls)
    %{frame |
      type: type,
      rolls: rolls,
      roll_index: roll_index,
      score: frame.score + roll
    }
  end

  defp frame_type(rolls, max_rolls) do
    pins = Enum.sum(rolls)
    rolls_left = max_rolls - length(rolls)
    case {pins, length(rolls), rolls_left} do
      {pins, _, _} when pins > 10 -> :overflow
      {10,   1, _}                -> :strike
      {10,   2, _}                -> :spare
      {_,    _, 0}                -> :open
      _                           -> :active
    end
  end

  def notify(frame = %Frame{id: id, roll_index: i}, {j, roll}) when id in 1..9 do
    if j - i <= num_bonus_rolls(frame) do
      %{frame | score: frame.score + roll}
    else
      frame
    end
  end

  def notify(frame, _) do
    frame
  end

  def next(%Frame{id: id}) when id in 1..9 do
    %Frame{id: id + 1}
  end

  def next(frame = %Frame{id: 10}) do
    num_bonus_rolls = num_bonus_rolls(frame)
    bonus(num_bonus_rolls)
  end

  def next(frame = %Frame{id: :bonus}) do
    num_bonus_rolls_left = frame.max_rolls - length(frame.rolls)
    bonus(num_bonus_rolls_left)
  end

  defp bonus(num_bonus_rolls) do
    if num_bonus_rolls > 0 do
      %Frame{id: :bonus, max_rolls: num_bonus_rolls}
    end
  end

  defp num_bonus_rolls(frame) do
    case frame.type do
      :strike -> 2
      :spare  -> 1
      :open   -> 0
    end
  end
end

defmodule Bowling do
  defstruct active: nil, frames: [], roll_index: 0

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
    frame = Frame.roll(game.active, event)
    game = notify_frames(game, event)
    update_game(game, frame)
  end

  defp notify_frames(game, event) do
    frames = Enum.map(game.frames, &(Frame.notify(&1, event)))
    %{game | frames: frames}
  end

  defp update_game(_game, %Frame{type: :overflow}) do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp update_game(game, frame = %Frame{type: :active}) do
    %{game | active: frame}
  end

  defp update_game(game, frame) do
    %{game | active: Frame.next(frame), frames: [frame | game.frames]}
  end

  def score(game = %Bowling{active: nil}) do
    game.frames |> Enum.map(&(&1.score)) |> Enum.sum()
  end

  def score(_) do
    {:error, "Score cannot be taken until the end of the game"}
  end
end
