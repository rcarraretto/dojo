defmodule Accumulate do
  def accumulate(list, fun) do
    _accumulate(list, fun, [])
  end

  def _accumulate([], _fun, acc), do: Enum.reverse(acc)

  def _accumulate([head | tail], fun, acc) do
    _accumulate(tail, fun, [fun.(head) | acc])
  end
end
