defmodule SecretHandshake do
  use Bitwise

  @types [
    {"wink", 0b1},
    {"double blink", 0b10},
    {"close your eyes", 0b100},
    {"jump", 0b1000},
  ]

  def commands(code) do
    actions = actions_for(code)
    if reverse?(code), do: actions |> Enum.reverse, else: actions
  end

  def actions_for(code) do
    @types
      |> Enum.filter(fn({_action, mask}) -> matches?(code, mask) end)
      |> Enum.map(&(elem(&1, 0)))
  end

  def matches?(code, mask) do
    (code &&& mask) == mask
  end

  def reverse?(code) do
    matches?(code, 0b10000)
  end
end
