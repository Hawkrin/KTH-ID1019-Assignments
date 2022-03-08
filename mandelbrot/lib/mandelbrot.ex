defmodule Mandelbrot do

  #Implements the computation of i given the complex value c.
  def mandelbrot(c = {r, i}, m) do # m = maximum iterations
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(m, z, c, m) do 0 end

  def test(i, z, c, m) do
    var = Cmplx.abs(z)
    if var <= 2.0 do
      z1 = Cmplx.add(Cmplx.sqr(z), c)
      test(i+1, z1, c, m)
    else i
    end
  end

end
