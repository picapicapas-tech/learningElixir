defmodule PaintByNumber do
  def palette_bit_size(color_count) when color_count <= 2, do: 1
  def palette_bit_size(color_count) when color_count > 2 do
    1 + palette_bit_size(color_count / 2)
  end
  

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0b00::2, 0b01::2, 0b10::2, 0b11::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    if picture == empty_picture() do
      nil
    else
      bit_size = palette_bit_size(color_count)
      <<value::size(bit_size), _::bitstring>> = picture
      value
    end
  end

  def drop_first_pixel(picture, color_count) do
    if picture == empty_picture() do
      picture
    else
      bit_size = palette_bit_size(color_count)
      <<_::size(bit_size), reduced_picture::bitstring>> = picture
      reduced_picture
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
