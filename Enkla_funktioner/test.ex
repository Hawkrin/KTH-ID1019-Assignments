defmodule Test do

  def double(n) do
    IO.puts(n)
  end

  # a function that converts from Fahrenheit to Celsius (the function is asfollows: C = (F − 32)/1.8)
  def fahrenheitToCelcius(x) do
    ((x - 32) / 1.8)
  end

  # a function that calculates the area of a rectangle give the length of the two sides
  def rectangleArea(side1, side2) do
    (side1 * side2)
  end

  # a function that calculates the area of a square, using the previous function
  def squareArea(side) do
    rectangleArea(side, side)
  end

  # a function that calculates the area of a circle given the radius
  def circleArea(radius) do
    alias :math, as: Math
    Math.pi() * (Math.pow(radius, 2))
  end

  # multiplication using addition/subtraction
  def product(m, n) do
    if m == 0 do
      0
    else
      product(m-1, n) + n
    end
  end

  # multiplication using addition/subtraction 2
  def product_case(m, n) do
    case m do
      0 ->
        0
    _ ->
      product_case(m-1, n) + n
    end
  end

  # multiplication using addition/subtraction 3
  def product_cond(m, n) do
    cond do
      m == 0 ->
        0
      true ->
        product_cond(m-1, n) + n
    end
  end

  # multiplication using addition/subtraction 4
  def product_clauses(0, _) do 0 end
  def product_clauses(m, n) do
    product_clauses(m-1, n) + n
  end

  # l = [1,2,3,4,5,6]

  # return the n’th element of the list l
  def nth(n, l) do
    Enum.at(l, n)
  end

  # return the number of elements in the list l
  def len(l) do
    Enum.count(l)
  end

  # return the sum of all elements in the list l, assume that all elements are integers
  def sum(l) do
    Enum.sum(l)
  end

  # return the sum of all elements in the list l, assume that all elements are integers
  def sum2([]) do
    0
  end

  def sum2([head|tails]) do
    head + sum2(tails)
  end


  # return a list where all elements are duplicated
  def duplicate(l) do
    List.duplicate(l, 2)
  end

  # add the element x to the list l if it is not in the list
  def add(x, l) do
    if(!Enum.member?(l, x)) do
      List.insert_at(l, List.last(l), x)
    else
      IO.puts("The number is already in the list")
    end
  end

  # add the element x to the list l if it is not in the list 2
  def add2(x,l) do
    if(!Enum.member?(l, x)) do
        [x | l]
    else
        IO.puts("The number is already in the list")
    end
  end

  # remove all occurrences of x in l
  def remove(x, l) do
    List.delete(l, x)
  end

  # return a list of unique elements in the list l, that is [:a, :b, :d] are the unique elements in the list [:a, :b, :a, :d, :a,:b, :b, :a]
  def unique(l) do
    Enum.uniq(l)
  end

  # return a list containing lists of equal elements, [:a, :a, :b, :c, :b, :a, :c] should return [[:a, :a, :a], [:b, :b], [:c, :c]]
  def pack(l) do
    Enum.chunk_by(l, &(rem(&1, 2) == 1))
  end

  # return a list where the order of elements is reversed
  def reverse(l) do
    Enum.reverse(l)
  end

  # fibonnaci function written recursively
  def fib(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> fib(n-1) + fib(n-2)
    end
  end

end
