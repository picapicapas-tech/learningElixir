defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  end

  def split_line(line) do
   String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/, line) do
      [_full_match, user_name] -> "[USER] #{user_name} #{line}"
      nil -> line
    end
  end
end
