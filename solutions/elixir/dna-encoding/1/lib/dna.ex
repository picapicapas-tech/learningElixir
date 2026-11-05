defmodule DNA do
  def encode_nucleotide(? ), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000
  def encode_nucleotide(code_point) do
    # Please implement the encode_nucleotide/1 function
  end

  def decode_nucleotide(0b0000), do: ? 
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T
  def decode_nucleotide(encoded_code) do
    # Please implement the decode_nucleotide/1 function
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acc), do: acc
  defp do_encode([head|tail], acc) do
    do_encode(tail, <<acc::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_decode(<<>>, acc), do: Enum.reverse(acc)
  defp do_decode(<<code::4, rest::bitstring>>, acc) do
    do_decode(rest, [decode_nucleotide(code) | acc])
  end
  
end
