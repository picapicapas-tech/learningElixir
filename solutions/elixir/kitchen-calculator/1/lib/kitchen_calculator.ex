defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter({:cup, _} = volume_pair) do
    {:milliliter, 240 * get_volume(volume_pair)}
  end

  def to_milliliter({:fluid_ounce, _} = volume_pair) do
    {:milliliter, 30 * get_volume(volume_pair)}
  end
  
  def to_milliliter({:teaspoon, _} = volume_pair) do
    {:milliliter, 5 * get_volume(volume_pair)}
  end
  
  def to_milliliter({:tablespoon, _} = volume_pair) do
    {:milliliter, 15 * get_volume(volume_pair)}
  end
  
  def to_milliliter({:milliliter, _} = volume_pair) do
    volume_pair
  end

  def from_milliliter(volume_pair, :cup = unit) do
    {:cup, get_volume(volume_pair) / 240}
  end

  def from_milliliter(volume_pair, :fluid_ounce = unit) do
    {:fluid_ounce, get_volume(volume_pair) / 30}
  end

  def from_milliliter(volume_pair, :teaspoon = unit) do
    {:teaspoon, get_volume(volume_pair) / 5}
  end

  def from_milliliter(volume_pair, :tablespoon = unit) do
    {:tablespoon, get_volume(volume_pair) / 15}
  end

  def from_milliliter(volume_pair, :milliliter = unit) do
    {:milliliter, get_volume(volume_pair)}
  end

  def convert(volume_pair, unit) do
    volume_in_ml = to_milliliter(volume_pair)
    from_milliliter(volume_in_ml, unit)
  end
end
