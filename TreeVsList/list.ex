defmodule Lst do

  #makes list of tuples
  def append(:nil, y) do y end #empty list
  def append({:cons, head, tail}, y) do #not empty list
    {:cons, head, append(tail, y)}
  end

end
