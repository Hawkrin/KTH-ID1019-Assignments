defmodule Morse do

  def test()do
      tree = morse()
      encode_table = encode_table(tree)
      my_name_encoded = encode(my_name(), encode_table)
      IO.puts(my_name_encoded)
      message1_decoded = decode(message1(), tree)
      IO.puts(message1_decoded)
      message2_decoded = decode(message2(), tree)
      IO.puts(message2_decoded)
  end

  def my_name() do
    'malcolm liljedahl'
  end

  def message1 do
      '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... '
  end

  def message2 do
      '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .-----
      .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- .....
      ---.. -.-. .--.-- ..... .---- '
  end

  #Create Encode table
  def encode_table(tree) do
      table = codes(tree, [])
      Enum.sort(table, fn({ascii1, _morse1}, {ascii2, _morse2}) -> ascii1 < ascii2 end)
  end
  def codes(:nil, _) do [] end
  def codes({:node, :na, long, short}, code) do
      codes(long, [?-|code]) ++ codes(short, [?.|code])
  end
  def codes({:node, char, long, short}, code) do
      [{char, Enum.reverse(code)}] ++ codes(long, [?-|code]) ++ codes(short, [?.|code])
  end

  #Encode
  def encode(text, table) do
      encode(text, [], table)
  end
  defp encode([], all, _), do: unpack(all, [])
  defp encode([char | rest], sofar, table) do
      code = lookup(char, table)
      encode(rest, [code | sofar], table)
  end
  def lookup(char, table) do
      encoding = List.keyfind(table, char, 0)
      elem(encoding, 1)
  end
  defp unpack([], done), do: done
  defp unpack([code | rest], sofar) do
      unpack(rest, code ++ [?\s | sofar])
  end

  #Decode
  def decode([], _) do [] end
  def decode(signal, table) do
    {char, rest} = decode_char(signal, table)
    [char | decode(rest, table)]
  end

  def decode_char([], {:node, character, left, right}) do {character, []} end
  def decode_char([h|t], {:node, character, left, right}) do
      case h do
          ?-  -> decode_char(t, left)
          ?.  -> decode_char(t, right)
          ?\s  -> {character, t}
          []  -> {character, []}
      end
  end

  def morse() do
  {:node, :na,
    {:node, 116,
      {:node, 109,
        {:node, 111,
          {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
          {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
        {:node, 103,
          {:node, 113, nil, nil},
          {:node, 122,
            {:node, :na, {:node, 44, nil, nil}, nil},
            {:node, 55, nil, nil}}}},
      {:node, 110,
        {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
        {:node, 100,
          {:node, 120, nil, nil},
          {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
    {:node, 101,
      {:node, 97,
        {:node, 119,
          {:node, 106,
            {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
            nil},
          {:node, 112,
            {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
            nil}},
        {:node, 114,
          {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
          {:node, 108, nil, nil}}},
      {:node, 105,
        {:node, 117,
          {:node, 32,
            {:node, 50, nil, nil},
            {:node, :na, nil, {:node, 63, nil, nil}}},
          {:node, 102, nil, nil}},
        {:node, 115,
          {:node, 118, {:node, 51, nil, nil}, nil},
          {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
  end
end
