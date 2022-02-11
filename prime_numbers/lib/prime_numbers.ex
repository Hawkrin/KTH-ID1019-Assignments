# ls elementen avgör längden på listan/trädet som ska testas
# bench() anropar sig självt med arg 100 (kmr loopa 100x).
# varje element i ls kastas in i bench. bench sitter på två funktioner, hur man skapar en lista och hur man skapar ett träd.
# elementet från ls i kombination med en funktion från bench anropar time. time skapar en lista av slumptal med längden 1..i (seq).
# timer anropar loop som tar argumenten: loop antal och en funktion(seq).
# i loop körs den givna funktionen och den innebär att en lista/träd skapas 100 gånger.
# timer mäter, hur lång tid tar det att skapa en ny lista/träd av talen från seq, 100 gånger?


defmodule BenchPrime do

  def bench() do bench(100) end

  def bench(l) do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.to_list(2..i)
      elem(:timer.tc(fn () -> loop(l, fn -> f.(seq) end) end), 0)
    end

    bench = fn (i) ->

      prime_one = fn(seq) ->
        primeFinder(seq)
      end
      prime_two = fn(seq) ->
        primtFinder2(seq, [])
      end
      prime_three = fn(seq) ->
        primeFinder3(seq, [])
      end

      tl = time.(i, prime_one)
      tt = time.(i, prime_two)
      tr = time.(i, prime_three)

      IO.write("  #{tl}\t\t\t#{tt}\t\t\t#{tr}\n")
    end

    IO.write("# Benchmark of different prime finding implementations, (loop: #{l}) \n")
    Enum.map(ls, bench)

    :ok
  end

  def loop(0,_) do :ok end
  def loop(n, f) do
    f.()
    loop(n-1, f)
  end

#PRIME FINDER 1
# h = 2 -> check the rest of the list if it can be divided by 2. -> take out the 2 and recursivley run the fucntion again with the new head as 3. -> do again.
    def primeFinder([]) do [] end
    def primeFinder([h|t]) do
        seq = [h|Enum.filter([h|t], fn e -> rem(e, h) != 0 end)]
        [hd(seq)|primeFinder(tl(seq))]
    end

#PRIME FINDER 2
#
  def primtFinder2([h1 | t1], []) do
      primtFinder2([h1 | t1], [h1]) # adds two to the list
  end
  def primtFinder2([], listOfPrimes) do
    listOfPrimes
  end
  def primtFinder2(full_list = [h1 | t1], listOfPrimes = [h2 | t2]) do
      primeFound = checkIfPrime(full_list, listOfPrimes)
      listOfPrimes = insertPrime(primeFound, h1, listOfPrimes)
      primtFinder2(t1, listOfPrimes)
  end
  def checkIfPrime(_, []) do true end
  def checkIfPrime(full_list = [h1 | t1], listOfPrimes = [h2 | t2]) do #check if prime number or not
      if rem(h1, h2) == 0 do
          false
      else
          checkIfPrime(full_list, t2)
      end
  end
  def insertPrime(primeFound, prime, listOfPrimes) do
      if primeFound do
        listOfPrimes ++ [prime]
      else
          listOfPrimes
      end
  end

#PRIME FINDER 3
  def primeFinder3([h1 | t1], []) do
      primeFinder3([h1 | t1], [h1]) #2
  end
  def primeFinder3([], listOfPrimes) do
      listOfPrimes = Enum.reverse(listOfPrimes)
  end
  def primeFinder3(full_list = [h1 | t1], listOfPrimes = [h2 | t2]) do
      primeFound = checkIfPrime2(full_list, listOfPrimes)
      listOfPrimes = insertPrime2(primeFound, h1, listOfPrimes)
      primeFinder3(t1, listOfPrimes)
  end
  def checkIfPrime2(_, []) do true end
  def checkIfPrime2(full_list = [h1 | t1], listOfPrimes = [h2 | t2]) do
      if rem(h1, h2) == 0 do
          false
      else
          checkIfPrime2(full_list, t2)
      end
  end
  def insertPrime2(primeFound, prime, listOfPrimes) do
      if primeFound do
          [prime | listOfPrimes ]
      else
          listOfPrimes
      end
  end
end
