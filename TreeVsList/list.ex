defmodule Lst do

  #makes list of tuples
  def append(:nil, y) do y end #empty list
  def append({:cons, head, tail}, y) do #not empty list
    {:cons, head, append(tail, y)}
  end

  def append(:nil, y) do y end #empty list
  def append({:cons, head, tail}, y) do #not empty list
    {:cons, head, append(tail, y)}
  end

  ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

  def list_new() do [] end

  def list_insert(e, l) do
      [e|l]
  end


end
