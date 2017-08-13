defmodule Forth do

  def new() do
    []
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  def eval(_ev, s) do
    s
    |> String.replace(~r/[^\w+-\\*\/]| /, " ")
    |> String.split()
    |> eval_tokens([])
  end

  defp eval_tokens([], stack) do
    Enum.reverse(stack)
  end

  defp eval_tokens(["+" | tokens], [y, x | stack]) do
    result = Integer.to_string(String.to_integer(x) + String.to_integer(y))
    eval_tokens(tokens, [result | stack])
  end

  defp eval_tokens(["-" | tokens], [y, x | stack]) do
    result = Integer.to_string(String.to_integer(x) - String.to_integer(y))
    eval_tokens(tokens, [result | stack])
  end

  defp eval_tokens(["*" | tokens], [y, x | stack]) do
    result = Integer.to_string(String.to_integer(x) * String.to_integer(y))
    eval_tokens(tokens, [result | stack])
  end

  # defp eval_tokens([_, "0", "/" | tokens]) do
  #   raise DivisionByZero
  # end

  defp eval_tokens(["/" | tokens], [y, x | stack]) do
    result = Integer.to_string(div(String.to_integer(x), String.to_integer(y)))
    eval_tokens(tokens, [result | stack])
  end

  defp eval_tokens([token | tokens], stack) do
    eval_tokens(tokens, [token | stack])
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  def format_stack(ev) do
    Enum.join(ev, " ")
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception [word: nil]
    def message(e), do: "invalid word: #{inspect e.word}"
  end

  defmodule UnknownWord do
    defexception [word: nil]
    def message(e), do: "unknown word: #{inspect e.word}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
