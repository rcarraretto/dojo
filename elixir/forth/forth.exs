defmodule Forth do

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
    |> token_types([])
    |> eval_tokens([])
  end

  defp token_types([], tokens) do
    Enum.reverse(tokens)
  end

  defp token_types([symbol | symbols], tokens) do
    token_types(symbols, [token_type(symbol) | tokens])
  end

  defp token_type("+"), do: :+
  defp token_type("-"), do: :-
  defp token_type("*"), do: :*
  defp token_type("/"), do: :/
  defp token_type(x) do
    cond do
      x =~ ~r/^[0-9]+$/ -> String.to_integer(x)
      true -> x
    end
  end

  defp eval_tokens([], stack) do
    Enum.reverse(stack)
  end

  defp eval_tokens([operator | tokens], [y, x | stack])
  when operator in [:+, :-, :*, :/] do
    result = eval_operator(operator, x, y)
    eval_tokens(tokens, [result | stack])
  end

  defp eval_tokens([token | tokens], stack) do
    eval_tokens(tokens, [token | stack])
  end

  defp eval_operator(:+, x, y), do: x + y
  defp eval_operator(:-, x, y), do: x - y
  defp eval_operator(:*, x, y), do: x * y
  defp eval_operator(:/, _, 0), do: raise DivisionByZero
  defp eval_operator(:/, x, y), do: div(x, y)

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  def format_stack(ev) do
    Enum.join(ev, " ")
  end
end
