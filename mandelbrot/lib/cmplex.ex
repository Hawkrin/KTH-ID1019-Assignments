defmodule Cmplx do

  #creates a complex number
  def new(r, i) do {r, i} end

  #various calculations for the complex numbers
  def add({a, ai}, {b, bi}) do {a+b, ai+bi} end

  def sqr({r, i}) do {r*r - i*i, 2*r*i} end

  def abs({r, i}) do :math.sqrt(r*r + i*i) end

end
