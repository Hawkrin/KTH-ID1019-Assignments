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
      sample = read(sample)
      tree = tree(sample)
      encode = encode_table(tree)
      decode = decode_table(tree)
      text = text()
      seq = encode(text, encode)
      decode(seq, decode)
    end

    # Construct the Huffman tree from a text sample.
    def tree(sample) do
      freq = freq(sample)
      tree(freq)
    end


    # Checks the frequency of the characters
    def freq(sample) do freq(sample, []) end

    def freq([], freq) do freq end
    def freq([char | rest], freq) do
      freq(rest, count(char, freq))
    end

    # If character is found, +1 frequency
    def count(char, []) do [{char, 1}] end
    def count(char, [{char, n} | freq]) do
      [{char, n + 1} | freq]
    end
    def count(char, [elem | freq]) do
      [elem | count(char, freq)]
    end


    # Create tree
    def tree(freq) do
      sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
      tree_creation(sorted)
    end

    def tree_creation([{tree, _}]) do tree end
    def tree_creation([{a, af}, {b, bf} | rest]) do
      tree_creation(insert({{a, b}, af + bf}, rest))
    end

    def insert({a, af}, []) do [{a, af}] end
    def insert({a, af}, [{b, bf} | rest]) when af < bf do
      [{a, af}, {b, bf} | rest]
    end
    def insert({a, af}, [{b, bf} | rest]) do
      [{b, bf} | insert({a, af}, rest)]
    end


  # Construct encoding table
  def encode_table(tree) do codes(tree, [], []) end

  def codes({a, b}, move, acc) do
    left  = codes(a, [0 | move], acc)
    codes(b, [1 | move], left)
  end
  def codes(a, code, acc) do [{a, Enum.reverse(code)} | acc] end

  # return the value if a key is found
  def find(_, []) do [] end
  def find(char, [{char, code} | _]) do code end
  def find(char, [{ _, _ }  | rest]) do find(char, rest) end


  # Encode using the table. return bits sequence
  def encode([], _) do [] end
  def encode([char | rest], table) do find(char, table) ++ encode(rest, table) end

  # Create decoding table containing
  def decode_table(tree) do codes(tree, [], []) end

  # Decode the sequence and return the text
  def decode([], _) do [] end
  def decode(seq, table) do
    {char, rest} = decode_characters(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_characters(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case charFinder(table, code) do
      {char, _} ->
          {char, rest}
      nil ->
          decode_characters(seq, n+1, table)
    end
  end

  # Find the character
  def charFinder([], _) do nil end
  def charFinder([{char, code} | _], code) do {char, code} end
  def charFinder([ _ | rest ], code) do
    charFinder(rest, code)
  end


    # This is the benchmark of the single operations in the
    # Huffman encoding and decoding process.

    def bench(file, n) do
      {text, b} = read(file)
      c = length(text)
      {tree, t2} = time(fn -> tree(text) end)
      {encode, t3} = time(fn -> encode_table(tree) end)
      s = length(encode)
      {decode, _} = time(fn -> decode_table(tree) end)
      {encoded, t5} = time(fn -> encode(text, encode) end)
      e = div(length(encoded), 8)
      r = Float.round(e / b, 3)
      {_, t6} = time(fn -> decode(encoded, decode) end)

      IO.puts("text of #{c} characters")
      IO.puts("tree built in #{t2} ms")
      IO.puts("table of size #{s} in #{t3} ms")
      IO.puts("encoded in #{t5} ms")
      IO.puts("decoded in #{t6} ms")
      IO.puts("source #{b} bytes, encoded #{e} bytes, compression #{r}")
    end

    # Measure the execution time of a function.
    def time(func) do
      initial = Time.utc_now()
      result = func.()
      final = Time.utc_now()
      {result, Time.diff(final, initial, :microsecond) / 1000}
    end

    # Get a suitable chunk of text to encode.
    def read(file) do
      {:ok, file} = File.open(file, [:read])
      binary = IO.read(file, :all)
      File.close(file)

      case :unicode.characters_to_list(binary, :utf8) do
        {:incomplete, list, _} ->
          list;
        list ->
          list
      end
    end
end
