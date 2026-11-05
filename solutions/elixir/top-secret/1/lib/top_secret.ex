defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, [{:when, _, [{name, _, args} | _]} | _]} = ast, acc)
      when op in [:def, :defp] do
    {ast, [secret_part(name, args) | acc]}
  end
  
  def decode_secret_message_part({op, _, [{name, _, args} | _]} = ast, acc)
      when op in [:def, :defp] do
    {ast, [secret_part(name, args) | acc]}
  end
  
  def decode_secret_message_part(ast, acc), do: {ast, acc}
  
  defp secret_part(name, args) do
    name
    |> Atom.to_string()
    |> String.slice(0, arity(args))
  end
  
  defp arity(nil), do: 0
  defp arity(args), do: length(args)

  def decode_secret_message(string) do
    {_ast, parts} =
      string
      |> to_ast()
      |> Macro.prewalk([], &decode_secret_message_part/2)
  
    parts
    |> Enum.reverse()
    |> Enum.join()
  end
end
