defmodule Strain do

  def keep(list, fun), do: _keep(list, fun, [])

  def _keep([], _fun, result), do: Enum.reverse(result)

  def _keep([head | tail], fun, result) do
    if fun.(head) do
      _keep(tail, fun, [head | result])
    else
      _keep(tail, fun, result)
    end
  end

  def discard(list, fun) do
    keep(list, &(!fun.(&1)))
  end
end
