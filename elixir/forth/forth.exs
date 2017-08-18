defmodule Forth do

  def new() do
    {[], %{}}
  end

  def eval(ev, s) do
    s
    |> String.replace(~r/[^\w+-\\*\/]| /, " ")
    |> String.split()
    |> Enum.map(&token_type/1)
    |> eval_tokens(ev)
  end

  defp token_type("+"), do: math_op(&Kernel.+/2)
  defp token_type("-"), do: math_op(&Kernel.-/2)
  defp token_type("*"), do: math_op(&Kernel.*/2)
  defp token_type("/"), do: math_op(&forth_div/2)
  defp token_type(symbol) do
    case Integer.parse(symbol) do
      {int, ""} -> int
      _         -> String.downcase(symbol)
    end
  end

  defp forth_div(_, 0), do: raise Forth.DivisionByZero
  defp forth_div(x, y), do: Kernel.div(x, y)

  defp math_op(operator) do
    fn([y, x | stack]) -> [operator.(x, y) | stack] end
  end

  defp eval_tokens([], {stack, words}) do
    {Enum.reverse(stack), words}
  end

  defp eval_tokens([operator | tokens], {stack, words})
    when is_function(operator) do
    eval_tokens(tokens, {operator.(stack), words})
  end

  defp eval_tokens([":", word | _], _) when is_integer(word) do
    raise Forth.InvalidWord
  end

  defp eval_tokens([":", word | tokens], {stack, words}) do
    {word_tokens, [";" | rem_tokens]} = Enum.split_while(tokens, &(&1 != ";"))
    eval_tokens(rem_tokens, {stack, Map.put(words, word, word_tokens)})
  end

  defp eval_tokens(all_tokens = [word | tokens], ev = {_, words})
    when is_binary(word) do
    case Map.fetch(words, word) do
      {:ok, word_tokens} -> eval_tokens(word_tokens ++ tokens, ev)
      :error             -> eval_built_in(all_tokens, ev)
    end
  end

  defp eval_tokens([token | tokens], {stack, words}) do
    eval_tokens(tokens, {[token | stack], words})
  end

  defp eval_built_in([op_str | tokens], {stack, words}) do
    {func, num_elems} = operator!(op_str)
    {stack, popped} = pop!(stack, num_elems)
    result = func.(popped)
    eval_tokens(tokens, {result ++ stack, words})
  end

  defp operator!("dup"),  do: {&dup/1, 1}
  defp operator!("drop"), do: {&drop/1, 1}
  defp operator!("swap"), do: {&swap/1, 2}
  defp operator!("over"), do: {&over/1, 2}
  defp operator!(_),      do: raise Forth.UnknownWord

  defp dup([x]),     do: [x, x]
  defp drop([_]),    do: []
  defp swap([x, y]), do: [y, x]
  defp over([x, y]), do: [y, x, y]

  defp pop!(stack, num_elems) do
    {elems, new_stack} = Enum.split(stack, num_elems)
    if length(elems) == num_elems do
      {new_stack, elems}
    else
      raise Forth.StackUnderflow
    end
  end

  def format_stack({stack, _}), do: Enum.join(stack, " ")

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
