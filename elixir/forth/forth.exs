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
    {[], %{}}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  def eval(ev, s) do
    s
    |> String.replace(~r/[^\w+-\\*\/]| /, " ")
    |> String.split()
    |> token_types([])
    |> eval_tokens(ev)
  end

  defp token_types([], tokens) do
    Enum.reverse(tokens)
  end

  defp token_types([symbol | symbols], tokens) do
    token_types(symbols, [token_type(symbol) | tokens])
  end

  defp token_type("+"), do: &Kernel.+/2
  defp token_type("-"), do: &Kernel.-/2
  defp token_type("*"), do: &Kernel.*/2
  defp token_type("/"), do: &forth_div/2
  defp token_type(x) do
    cond do
      x =~ ~r/^[0-9]+$/ -> String.to_integer(x)
      true -> String.downcase(x)
    end
  end

  defp forth_div(_, 0), do: raise DivisionByZero
  defp forth_div(x, y), do: Kernel.div(x, y)

  defp eval_tokens([], {stack, words}) do
    {Enum.reverse(stack), words}
  end

  defp eval_tokens([operator | tokens], {[y, x | stack], words})
    when is_function(operator) do
    result = operator.(x, y)
    eval_tokens(tokens, {[result | stack], words})
  end

  defp eval_tokens([op | _], {[], _}) when op in ["dup", "drop", "swap", "over"] do
    raise StackUnderflow
  end

  defp eval_tokens([op | _], {[_], _}) when op in ["swap", "over"] do
    raise StackUnderflow
  end

  defp eval_tokens(["dup" | tokens], {[x | stack], words}) do
    eval_tokens(tokens, {[x, x | stack], words})
  end

  defp eval_tokens(["drop" | tokens], {[_ | stack], words}) do
    eval_tokens(tokens, {stack, words})
  end

  defp eval_tokens(["swap" | tokens], {[x, y | stack], words}) do
    eval_tokens(tokens, {[y, x | stack], words})
  end

  defp eval_tokens(["over" | tokens], {[x, y | stack], words}) do
    eval_tokens(tokens, {[y, x, y | stack], words})
  end

  defp eval_tokens([":", word | tokens], {stack, words}) do
    {word_tokens, [";" | rem_tokens]} = Enum.split_while(tokens, &(&1 != ";"))
    eval_tokens(rem_tokens, {stack, Map.put(words, word, word_tokens)})
  end

  defp eval_tokens([word | tokens], {stack, words}) when is_binary(word) do
    word_tokens = Map.get(words, word)
    eval_tokens(word_tokens ++ tokens, {stack, words})
  end

  defp eval_tokens([token | tokens], {stack, words}) do
    eval_tokens(tokens, {[token | stack], words})
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  def format_stack({stack, _}) do
    Enum.join(stack, " ")
  end
end
