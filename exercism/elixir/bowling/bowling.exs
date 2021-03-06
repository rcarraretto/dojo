# Elixir v1.5.1
defmodule Frame do
  defstruct id: 1, type: :active, rolls: [], index: 0, max_rolls: 2, score: 0

  @last_frame 10
  @pins 10

  def roll(frame = %Frame{index: i}, roll) do
    event = {i + 1, roll}
    {update(frame, event), event}
  end

  defp update(frame, {index, roll}) do
    rolls = [roll | frame.rolls]
    type = type(rolls, frame.max_rolls)
    score = frame.score + roll
    %{frame | type: type, rolls: rolls, index: index, score: score}
  end

  defp type(rolls, max_rolls) do
    pins = Enum.sum(rolls)
    num_rolls = length(rolls)
    num_rolls_left = max_rolls - num_rolls
    case {pins, num_rolls, num_rolls_left} do
      {pins,  _, _} when pins > @pins -> :overflow
      {@pins, 1, _}                   -> :strike
      {@pins, 2, _}                   -> :spare
      {_,     _, 0}                   -> :open
      _                               -> :active
    end
  end

  def notify_all(frames, event) do
    Enum.map(frames, &(notify(&1, event)))
  end

  defp notify(frame = %Frame{id: id, index: i}, {j, roll}) when id < @last_frame do
    if j - i <= num_bonus_rolls(frame) do
      %{frame | score: frame.score + roll}
    else
      frame
    end
  end

  defp notify(frame, _) do
    frame
  end

  def next(%Frame{id: id, index: i}) when id < @last_frame do
    %Frame{id: id + 1, index: i}
  end

  def next(frame = %Frame{id: @last_frame}) do
    num_bonus_rolls = num_bonus_rolls(frame)
    bonus(frame, num_bonus_rolls)
  end

  def next(frame = %Frame{id: :bonus}) do
    num_bonus_rolls_left = frame.max_rolls - length(frame.rolls)
    bonus(frame, num_bonus_rolls_left)
  end

  defp bonus(%Frame{index: i}, num_bonus_rolls) do
    if num_bonus_rolls > 0 do
      %Frame{id: :bonus, max_rolls: num_bonus_rolls, index: i}
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
  defstruct frame: nil, frames: []

  def start do
    %Bowling{frame: %Frame{}}
  end

  def roll(_game, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(%Bowling{frame: nil}, _roll) do
    {:error, "Cannot roll after game is over"}
  end

  def roll(game, roll) do
    {frame, event} = Frame.roll(game.frame, roll)
    frames = Frame.notify_all(game.frames, event)
    next(game, frame, frames)
  end

  defp next(_game, %Frame{type: :overflow}, _frames) do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp next(game, frame = %Frame{type: :active}, frames) do
    %{game | frame: frame, frames: frames}
  end

  defp next(game, frame, frames) do
    %{game | frame: Frame.next(frame), frames: [frame | frames]}
  end

  def score(game = %Bowling{frame: nil}) do
    game.frames |> Enum.map(&(&1.score)) |> Enum.sum()
  end

  def score(_) do
    {:error, "Score cannot be taken until the end of the game"}
  end
end
