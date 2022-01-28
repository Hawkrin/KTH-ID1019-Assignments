defmodule Derivate do

  @type literal() :: {:num, number()} | {:var, atom()}
  @type expr() :: literal()
  | {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | {:expr, expr(), literal()}
  | {:ln, expr()}
  | {:sin, expr()}
  | {:cos, expr() }


  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end

  def deriv({:add, e1, e2}, v) do {:add, deriv(e1,v), deriv(e2,v)} end

  def deriv({:mul, e1, e2}, v) do {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}} end

  def deriv({:exp, e, {:num, n}}, v) do {:mul, {:mul, {:num, n}, {:exp, e, {:num, n-1}}}, deriv(e, v)} end

  def deriv({:exp, {:var, x}, {:var, n}}, v) do {:mul, {:var, n}, {:exp, {:var, x}, {:add, {:var, n}, {:num, -1}}}} end #x^n

  def deriv({:sin, e}, v) do {:mul, deriv(e, v), {:cos, e}} end #sin(x)

  def deriv({:cos, e}, v) do {:mul, {:num, -1}, {:mul, deriv(e, v), {:sin, e}}} end #cos(x)

  def deriv({:ln,{:var, x}}, _v) do {:exp, {:var,x}, {:num, -1}} end #ln(x)


  def calc({:num, n}, _, _) do {:num, n} end
  def calc({:var, v}, v, n) do {:num, n} end
  def calc({:var, v}, _, _) do {:var, v} end
  def calc({:add, e1, e2}, v, n) do {:add, calc(e1, v, n), calc(e2, v, n)} end
  def calc({:mul, e1, e2}, v, n) do {:mul, calc(e1, v, n), calc(e2, v, n)} end
  def calc({:exp, e1, e2}, v, n) do {:exp, calc(e1, v, n), calc(e2, v, n)} end

  def simplify({:add, e1, e2}) do simplify_add(simplify(e1), simplify(e2)) end
  def simplify({:mul, e1, e2}) do simplify_mul(simplify(e1), simplify(e2)) end
  def simplify({:exp, e1, e2}) do simplify_exp(simplify(e1), simplify(e2)) end
  def simplify(e) do e end

  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1,n2)} end
  def simplify_exp(e1, e2) do {:exp, e1 ,e2} end

  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)})^(#{pprint(e2)})" end
  def pprint({:ln, e1}) do "ln(#{pprint(e1)})" end
  def pprint({:sin, e1}) do "sin(#{pprint(e1)})" end
  def pprint({:cos, e1}) do "cos(#{pprint(e1)})" end

  def test1() do
    e={:add,
        {:mul, {:num, 2}, {:var, :x}},
        {:num, 4}}
    d=deriv(e, :x)
    c=calc(d, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
    :ok
  end

  def test2() do
    e={:add,
        {:exp, {:var, :x}, {:num, 3}},
        {:num, 4}}
    d=deriv(e, :x)
    c=calc(d, :x, 4)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
    :ok
  end

  def test3() do
    e={{:ln, {:var, :x}}}
    d=deriv(e, :x)
    c=calc(d, :x, 4)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
    :ok
  end

  #test sin(x)
  def test4()do
    e ={:sin, {:var, :x}}
    d = deriv(e, :x)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
    :ok
  end

  #test cos(x)
  def test5()do
    e ={:cos, {:var, :x}}
    d = deriv(e, :x)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
    :ok
  end

  #test x^n
  def test6() do
    e={:exp, {:var,:x}, {:var,:p}}
    d=deriv(e, :x)
    c=calc(d, :n, 2)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    :ok
  end

  #test ln(x)
  def test7() do
    e={:ln, {:var, :x}}
    d=deriv(e, :x)
    c=calc(d, :x, 2)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
    :ok
  end

  #test Sqrt(x)
  def test8() do
    e={:exp, {:var,:x}, {:num, 0.5}}
    d=deriv(e, :x)
    c=calc(d, :n, 2)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    :ok
  end

  #test 1/x
  def test9() do
    e={:exp, {:var,:x}, {:num,-1}}
    d=deriv(e, :x)
    c=calc(d, :n, 2)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    :ok
  end

end
