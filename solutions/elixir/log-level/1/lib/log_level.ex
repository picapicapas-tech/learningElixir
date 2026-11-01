defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and !legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4-> :error
      level == 5 and !legacy? -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    loglevel = to_label(level, legacy?)
    cond do
      loglevel == :error or loglevel == :fatal -> :ops
      loglevel == :unknown and legacy? -> :dev1
      loglevel == :unknown and !legacy? -> :dev2
      true -> false
    end
  end
end
