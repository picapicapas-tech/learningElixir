defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name)
    |> String.at(0)
  end

  def initial(name) do
    first_letter(name)
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    [first_name, second_name] = String.split(full_name)
    initial(first_name) <> " " <> initial(second_name)
  end

  def pair(full_name1, full_name2) do
    """
    ❤-------------------❤
    |  #{initials(full_name1)}  +  #{initials(full_name2)}  |
    ❤-------------------❤
    """
  end
end
