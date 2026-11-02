defmodule BirdCount do
  def today([]), do: nil

  def today(list) do
    hd(list)
  end

  def increment_day_count([]) do
    [1]
  end

  def increment_day_count(list) do
    [hd(list) + 1 | tl(list)]
  end

  def has_day_without_birds?([]), do: false

  def has_day_without_birds?(list) do
    if (hd(list) == 0) do
      true
    else
      has_day_without_birds?(tl(list))
    end
  end

  def total([]), do: 0
  
  def total(list) do
    hd(list) + total(tl(list))
  end

  def busy_days([]), do: 0

  def busy_days(list) do
    if (hd(list) >= 5) do
      1 + busy_days(tl(list))
    else
      busy_days(tl(list))
    end
  end
end
