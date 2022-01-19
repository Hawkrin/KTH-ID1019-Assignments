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


end
