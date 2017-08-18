defmodule Forth do
  defmodule Ev do
    defstruct stack: [], words: %{}
  end

  def new() do
    %Ev{}
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

  defp math_op(operator) do
    fn([y, x | stack]) -> [operator.(x, y) | stack] end
  end

  defp forth_div(_, 0), do: raise Forth.DivisionByZero
  defp forth_div(x, y), do: Kernel.div(x, y)

  defp eval_tokens([], ev = %Ev{stack: stack}) do
    %{ev | stack: Enum.reverse(stack)}
  end

  defp eval_tokens([operator | tokens], ev = %Ev{stack: stack})
    when is_function(operator) do
    new_stack = operator.(stack)
    eval_tokens(tokens, %{ev | stack: new_stack})
  end

  defp eval_tokens([":", word | _], _) when is_integer(word) do
    raise Forth.InvalidWord
  end

  defp eval_tokens([":", word | tokens], ev = %Ev{words: words}) do
    {word_tokens, [";" | rem_tokens]} = Enum.split_while(tokens, &(&1 != ";"))
    new_words = Map.put(words, word, word_tokens)
    eval_tokens(rem_tokens, %{ev | words: new_words})
  end

  defp eval_tokens(all_tokens = [word | tokens], ev = %Ev{words: words})
    when is_binary(word) do
    case Map.fetch(words, word) do
      {:ok, word_tokens} -> eval_tokens(word_tokens ++ tokens, ev)
      :error             -> eval_built_in(all_tokens, ev)
    end
  end

  defp eval_tokens([token | tokens], ev = %Ev{stack: stack}) do
    eval_tokens(tokens, %{ev | stack: [token | stack]})
  end

  defp eval_built_in([op_str | tokens], ev = %Ev{stack: stack}) do
    operator = built_in_operator!(op_str)
    new_stack = operator.(stack)
    eval_tokens(tokens, %{ev | stack: new_stack})
  end

  defp built_in_operator!("dup"),  do: stack_op(&dup/1, 1)
  defp built_in_operator!("drop"), do: stack_op(&drop/1, 1)
  defp built_in_operator!("swap"), do: stack_op(&swap/1, 2)
  defp built_in_operator!("over"), do: stack_op(&over/1, 2)
  defp built_in_operator!(_),      do: raise Forth.UnknownWord

  defp stack_op(func, num_elems) do
    fn(stack) ->
      {new_stack, popped} = pop!(stack, num_elems)
      func.(popped) ++ new_stack
    end
  end

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

  def format_stack(%Ev{stack: stack}), do: Enum.join(stack, " ")

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
