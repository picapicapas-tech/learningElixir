defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract(data, String.split(path, "."))
  end

  defp do_extract(data, []), do: data
  defp do_extract(data, [key | rest]), do: do_extract(data[key], rest)


  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
