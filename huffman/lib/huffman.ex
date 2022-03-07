defmodule Huffman do

  def sample do
      'the quick brown fox jumps over the lazy dog
      this is a sample text that we will use when we build
      up a table we will only handle lower case letters and
      no punctuation symbols the frequency will of course not
      represent english but it is probably not that far off'
    end

    def text() do
      'this is something that we should encode'
    end

    def test do
      sample = sample()
      tree = tree(sample)
      encode = encode_table(tree)
      decode = decode_table(tree)
      text = text()
      seq = encode(text, encode)
      decode(seq, decode)
    end

    #calculating the frequency out of every character in our text
    def freq(sample) do freq(sample, []) end

    def freq([], freq) do freq end

    def freq([char | rest], freq) do
      freq(rest, update(char, freq))
    end

    def update(char, []) do [{char, 1}] end

    def update(char, [{char, n} | freq]) do
      [{char, n + 1} | freq]
    end

    def update(char, [elem | freq]) do
      [elem | update(char, freq)]
    end

    #sorting the calculated frequencys
    def huffman(freq) do
      sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
      tree(sorted)
    end

    #buildig a tree out of the counted characters
    def tree([{tree, _}]) do tree end

    def tree([{a, aFreq}, {b, bFreq} | rest]) do
      tree(insert({{a, b}, aFreq + bFreq}, rest))
    end

    def insert({a, aFreq}, []) do [{a, aFreq}] end

    def insert({a, aFreq}, [{b, bFreq} | rest]) when aFreq < bFreq do
      [{a, aFreq}, {b, bFreq} | rest]
    end

    def insert({a, aFreq}, [{b, bFreq} | rest]) do
      [{b, bFreq} | insert({a, aFreq}, rest)]
    end

    # Build the encoding table.
  def encode_table(tree) do
    Enum.sort( codes(tree, [], []), fn({_,x},{_,y}) -> length(x) < length(y) end)
  end

  # Traverse the Huffman tree and build a binary encoding for each character.
  def codes({a, b}, sofar) do
    as = codes(a, [0 | sofar])
    bs = codes(b, [1 | sofar])
    as ++ bs
  end

  def codes( a, code) do
    [{a, Enum.reverse(code)}]
  end

  # Decode a string of text using the same encoding table as above.
  def decode_table(tree) do codes(tree, []) end

  def decode([], _) do [] end

  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest}

      nil ->
        decode_char(seq, n + 1, table)
    end
  end



end
