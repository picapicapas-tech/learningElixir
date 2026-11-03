defmodule Username do
  def sanitize([]), do: []
  
  def sanitize(username) do
    current_char_ascii = hd(username)
    case current_char_ascii do
      current_char_ascii when current_char_ascii == ?_ -> [current_char_ascii | sanitize(tl(username))]
      current_char_ascii when current_char_ascii == ?ä -> [?a, ?e] ++ sanitize(tl(username))
      current_char_ascii when current_char_ascii == ?ö -> [?o, ?e] ++ sanitize(tl(username))
      current_char_ascii when current_char_ascii == ?ü -> [?u, ?e] ++ sanitize(tl(username))
      current_char_ascii when current_char_ascii == ?ß -> [?s, ?s] ++ sanitize(tl(username))
      current_char_ascii when current_char_ascii < ?a -> sanitize(tl(username))
      current_char_ascii when current_char_ascii > ?z -> sanitize(tl(username))
      _ ->  [current_char_ascii | sanitize(tl(username))]
    end
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    # Please implement the sanitize/1 function
  end
end
